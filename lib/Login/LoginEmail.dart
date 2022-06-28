import 'package:astrall/TelasIniciais/Home.dart';
import 'package:astrall/model/Usuario.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginEmail extends StatefulWidget {
  @override
  _LoginEmailState createState() => _LoginEmailState();
}

class _LoginEmailState extends State<LoginEmail> {

  String _mensagemErro = "";
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();

  _validarCampos() {
    //recuperar dados dos campos
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;

    if (email.isNotEmpty) {
      if (senha.isNotEmpty) {
        setState(() {
          _mensagemErro = "";
        });

        Usuario usuario = Usuario();
        usuario.email = email;
        usuario.senha = senha;

        _logarUsuario(usuario);
      } else {
        setState(() {
          _mensagemErro = "Preencha uma senha maior que 6 caracteres";
        });
      }
    } else {
      setState(() {
        _mensagemErro = "Preencha seu email";
      });
    }
  }

  _logarUsuario(Usuario usuario) {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.signInWithEmailAndPassword(
        email: usuario.email,
        password: usuario.senha
    ).then((firebaseUser) {

      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => Home()));

    }).catchError((error) {
      setState(() {
        _mensagemErro = "Erro ao logar, verifique email e senha";
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
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/imagens/bgLoginEmail.png"), fit: BoxFit.cover)),
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
                              "E-mail :",
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
                                  "Entrar".toUpperCase(),
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
      ),
    );
  }
}
