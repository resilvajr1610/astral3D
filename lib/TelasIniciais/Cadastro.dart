import 'dart:convert';
import 'package:astrall/model/Usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:http/http.dart';
import 'Home.dart';
class Cadastro extends StatefulWidget {
  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {

  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  String _mensagemErro = "";

  Future<Response> sendNotification(List<String> tokenIdList, String contents, String heading) async{

    return await post(
      Uri.parse('https://onesignal.com/api/v1/notifications'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>
      {
        "app_id": "6644a269-17ee-446b-9fd7-3cf0cece0901",//kAppId is the App Id that one get from the OneSignal When the application is registered.

        "include_player_ids": tokenIdList,//tokenIdList Is the List of All the Token Id to to Whom notification must be sent.

        // android_accent_color reprsent the color of the heading text in the notifiction
        "android_accent_color":"0xff61aef5",

        "small_icon":"https://firebasestorage.googleapis.com/v0/b/astral-69e69.appspot.com/o/playstore.png?alt=media&token=eb93999a-d6ac-4bcc-ae1f-62fab413af3c",

        "large_icon":"https://firebasestorage.googleapis.com/v0/b/astral-69e69.appspot.com/o/playstore.png?alt=media&token=eb93999a-d6ac-4bcc-ae1f-62fab413af3c",

        "headings": {"en": heading},

        "contents": {"en": contents},
      }),
    );
  }

  _validarCampos()async {
    //recuperar dados dos campos
    String nome = _controllerNome.text;
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;

    if (nome.isNotEmpty) {
      if (email.isNotEmpty) {
        if(senha.isNotEmpty){
          setState(() {
            _mensagemErro = "";
          });
          var status = await OneSignal.shared.getDeviceState();
          String tokenId = status.userId;
          Usuario usuario = Usuario();
          usuario.nome = nome;
          usuario.email = email;
          usuario.senha = senha;
          usuario.idOneSignal = tokenId;
          sendNotification([tokenId]," Cadastrado com Sucesso!","Astral 3D");
          _cadastrarUsuario(usuario);
        }else{
          setState(() {
            _mensagemErro = "Preencha uma senha maior que 6 caracteres";
          });
        }
      } else {
        setState(() {
          _mensagemErro = "Preencha seu e-mail";
        });
      }
    } else {
      setState(() {
        _mensagemErro = "Preencha seu nome";
      });
    }
  }

  _cadastrarUsuario(Usuario usuario){

    FirebaseAuth auth = FirebaseAuth.instance;
    auth.createUserWithEmailAndPassword(
        email: usuario.email,
        password: usuario.senha
    ).then((firebaseUser){

      //salvar dados do usuario
      Firestore db = Firestore.instance;
      db.collection("usuarios")
          .document(firebaseUser.uid)
          .setData(usuario.toMap());

      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => Cadastro()));

    }).catchError((error){
      setState(() {
        _mensagemErro = " Erro ao cadastrar usuario";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(right: 10,left: 10),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/imagens/bgCadastro.png"), fit: BoxFit.cover)),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 50,),
                Container(
                  child: Card(
                    color: Color(0xffe9eced),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Nome completo:",
                              style: TextStyle(
                                  color: Color(0xff222222),
                                  fontSize: 16,
                                  fontFamily: 'Montserrat'),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 8),
                            child: TextField(
                                controller: _controllerNome,
                                keyboardType: TextInputType.text,
                                style: TextStyle(fontSize: 15),
                                decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    contentPadding: EdgeInsets.fromLTRB(16, 2, 16, 2),
                                    filled: true,
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white,width: 0))
                                )
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "E-mail:",
                              style: TextStyle(
                                  color: Color(0xff222222),
                                  fontSize: 16,
                                  fontFamily: 'Montserrat'),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 8),
                            child: TextField(
                                controller: _controllerEmail,
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(fontSize: 15),
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  contentPadding: EdgeInsets.fromLTRB(16, 2, 16, 2),
                                  focusedBorder: InputBorder.none,
                                  filled: true,
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white,width: 0))
                                )
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Senha:",
                              style: TextStyle(
                                  color: Color(0xff222222),
                                  fontSize: 16,
                                  fontFamily: 'Montserrat'),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 8),
                            child: TextField(
                                controller: _controllerSenha,
                                keyboardType: TextInputType.text,
                                obscureText: true,
                                style: TextStyle(fontSize: 15),
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  contentPadding: EdgeInsets.fromLTRB(16, 2, 16, 2),
                                  focusedBorder: InputBorder.none,
                                  filled: true,
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white,width: 0))
                                )
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(top:10,left: 30,right: 30,bottom: 10),
                            child: RaisedButton(
                                child: Text(
                                  "cadastrar".toUpperCase(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontFamily: 'Montserrat'),
                                ),
                                color: Color(0xff56c1ca),
                                elevation: 5,
                                padding: EdgeInsets.fromLTRB(32, 9, 32, 9),

                                onPressed: () {
                                  _validarCampos();
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Center(
                    child: Text(
                      _mensagemErro,
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 15
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}
