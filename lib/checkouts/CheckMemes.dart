import 'dart:convert';
import 'dart:io';
import 'package:astrall/TelasIniciais/Splash.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:astrall/model/Comprar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:mercado_pago_mobile_checkout/mercado_pago_mobile_checkout.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class CheckMemes extends StatefulWidget {
  String comprar;
  CheckMemes(this.comprar);

  @override
  _CheckMemesState createState() => _CheckMemesState();
}

class _CheckMemesState extends State<CheckMemes> {

  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerCEP = TextEditingController();
  TextEditingController _controllerRua = TextEditingController();
  TextEditingController _controllerCidade = TextEditingController();
  TextEditingController _controllerEstado = TextEditingController();
  TextEditingController _controllerBairro = TextEditingController();
  TextEditingController _controllerNumero = TextEditingController();
  TextEditingController _controllerTelefone = TextEditingController();
  TextEditingController _controllerAP = TextEditingController();
  String _idCompra;
  int _valueFrete = 1;
  String _frete;
  double _totalCompra;
  bool _salvarDados = false;
  String _preco;
  String _idUsuarioLogado;
  String _mensagemErro = "";
  String _mensagem = "";
  String _publicKey = "TEST-174a55a7-6af2-49ba-9cd9-5b38b978e0ce";
  String _idPagamento;
  String _token;
  String _tokenCliente;

  @override
  void initState() {
    super.initState();
    _idCompra = widget.comprar;
    _recuperarDadosUsuario();
    _recuperarDadosVendedor();
  }

  _recuperarDadosUsuario()async{

    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser usuarioLogado = await auth.currentUser();
    _idUsuarioLogado = usuarioLogado.uid;

    Firestore db = Firestore.instance;
    DocumentSnapshot snapshot = await
    db.collection("comprar")
        .document(_idCompra)
        .get();
    Map<String, dynamic> dados = snapshot.data;
    setState(() {
      _preco = dados["preco"].toString();
    });
  }
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
  _recuperarDadosVendedor()async{

    Firestore db = Firestore.instance;
    DocumentSnapshot snapshot = await
    db.collection("vendedor")
        .document("token")
        .get();
    Map<String, dynamic> dados = snapshot.data;
    setState(() {
      _token = dados["idOneSignal"].toString();
    });
  }

  _validarCampos() {
    DateTime hoje = DateTime.now();
    var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
    var inputDate = inputFormat.parse(hoje.toString());
    var outputFormat = DateFormat('dd/MM/yyyy');
    String data = outputFormat.format(inputDate);
    //recuperar dados dos campos
    String nome = _controllerNome.text;
    String cep = _controllerCEP.text;
    String cidade = _controllerCidade.text;
    String estado = _controllerEstado.text;
    String bairro = _controllerBairro.text;
    String numero = _controllerNumero.text;
    String telefone = _controllerTelefone.text;
    String ap = _controllerAP.text;
    String rua = _controllerRua.text;

    if(nome.isNotEmpty){
      if(rua.isNotEmpty){
        if (numero.isNotEmpty) {
          if (bairro.isNotEmpty) {
            if(cidade.isNotEmpty){
              if(estado.isNotEmpty){
                if(cep.isNotEmpty){
                  if(telefone.isNotEmpty){
                    if(_frete!=null){
                      setState(() {
                        _mensagemErro = "";
                      });
                      Comprar comprar = Comprar();
                      comprar.nome = nome;
                      comprar.cep = cep;
                      comprar.rua = rua;
                      comprar.cidade = cidade;
                      comprar.estado = estado;
                      comprar.bairro = bairro;
                      comprar.numero = numero;
                      comprar.telefone = telefone;
                      comprar.ap = ap;
                      comprar.frete = _frete;
                      comprar.precoPago = _totalCompra;
                      comprar.data = data;
                      _cadastrarCompra(comprar);
                    }else{
                      setState(() {
                        _mensagemErro = "Selecione o frete";
                      });
                    }
                  }else{
                    setState(() {
                      _mensagemErro = "Preencha o número do seu celular";
                    });
                  }
                }else{
                  setState(() {
                    _mensagemErro = "Preencha o CEP da sua rua";
                  });
                }
              }else{
                setState(() {
                  _mensagemErro = "Preencha o seu estado";
                });
              }
            }else{
              setState(() {
                _mensagemErro = "Preencha sua cidade";
              });
            }
          } else {
            setState(() {
              _mensagemErro = "Preencha seu bairro";
            });
          }
        } else {
          setState(() {
            _mensagemErro = "Preencha o número da sua casa";
          });
        }
      }else{
        setState(() {
          _mensagemErro = "Preencha a rua da sua casa";
        });
      }
    }else{
      setState(() {
        _mensagemErro = "Preencha seu nome";
      });
    }
  }
  _cadastrarCompra(Comprar comprar)async{
    //salvar dados do usuario
    Firestore db = Firestore.instance;
    db.collection("comprar")
        .document(_idCompra)
        .updateData(comprar.toCompra()).then((value){
      _salvarDados = true;
      getData();
    });
  }
  Future<void> getData()async{
    var res = await http.post(Uri.parse("https://api.mercadopago.com/checkout/preferences?access_token=TEST-2830808265180597-071819-836e7650fa5c9b968a4b36cfb9a46934-10733880"),
        body: jsonEncode(
            {
              "items": [
                {
                  "title": "Astral 3D",
                  "description": "Produto Memes",
                  "quantity": 1,
                  "currency_id": "ARS",
                  "unit_price": _totalCompra
                }
              ],
              "payer": {
                "email": "cliente@astral3d.com"
              }
            }
        )
    );
    print(res.body);
    var json = jsonDecode(res.body);
    _idPagamento = json['id'];
  }
  _atualizarStatus()async{

    var status = await OneSignal.shared.getDeviceState();
    _tokenCliente = status.userId;
    sendNotification([_tokenCliente],"Compra realizada com sucesso!","Astral 3D");

    Firestore db = Firestore.instance;
    Map<String,dynamic> dadosAtualizar = {
      "status" : "solicitado",
      "tokenCliente" : _tokenCliente,
      "ok" : "ok"
    };
    db.collection("comprar")
        .document(_idCompra)
        .updateData(dadosAtualizar);
    sendNotification([_token],"Nova compra foi registrada!","Astral 3D");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backwardsCompatibility: false,
        backgroundColor: Color(0xff373739),
        title: Image.asset(
          "assets/imagens/logo1.png",
          alignment: Alignment.center,
          width: 120,
          height: 80,
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            color: Colors.black
        ),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(bottom: 10,top: 30),
                  child: Text('Frete :'.toUpperCase(),
                    style: TextStyle(color: Colors.white,
                        fontSize: 20,fontWeight: FontWeight.bold,fontFamily: 'Montserrat'),
                  ),
                ),
                Card(
                  margin: EdgeInsets.only(top: 10,right: 30,left: 30),
                  color: Color(0xff373739),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10,right: 10,left: 10),
                        child: Text('Selecione frete grátis e Mande depois um PRINT, avaliando o aplicativo em 5 estrelas e mandando para 3 contatos. Encaminhando para o Whatsapp: (73) 9 9105-5558.',
                          style: TextStyle(color: Color(0xff929090),fontSize: 10,
                              fontWeight: FontWeight.bold,fontFamily: 'Montserrat'),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Row(
                        children: [
                          Radio(
                              activeColor: Color(0xff18656d),
                              value: 2,
                              groupValue: _valueFrete,
                              onChanged: (value){
                                setState(() {
                                  _valueFrete = value;
                                  _frete = "gratis";
                                  var preco = double.parse(_preco);
                                  _totalCompra = preco;
                                });
                              }
                          ),
                          SizedBox(width: 5),
                          Text('Frete Grátis'.toUpperCase(),style: TextStyle(color: Colors.white,
                              fontWeight: FontWeight.bold,fontFamily: 'Montserrat'))
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                              activeColor: Color(0xff18656d),
                              value: 3,
                              groupValue: _valueFrete,
                              onChanged: (value){
                                setState(() {
                                  _valueFrete = value;
                                  _frete = "padrão";
                                  var preco = double.parse(_preco);
                                  var total = preco + 39.90;
                                  _totalCompra = total;
                                  print("preco : "+_totalCompra.toString());
                                  print("Frete : "+_frete);
                                });
                              }
                          ),
                          SizedBox(width: 5),
                          Text('Frete Padrão - R\$ 39,90'.toUpperCase(), style: TextStyle(color: Colors.white,
                              fontWeight: FontWeight.bold,fontFamily: 'Montserrat'))
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 15),
                            alignment: Alignment.centerLeft,
                            child: Text('Nome Completo :'.toUpperCase(),style: TextStyle(color: Colors.white,
                                fontWeight: FontWeight.bold,fontFamily: 'Montserrat')),
                          ),
                          Container(
                            height: 40,
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(right: 10,left: 10,top: 5,bottom: 5),
                            child: TextField(
                                controller: _controllerNome,
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.text,
                                style: TextStyle(fontSize: 12,color: Color(0xff929090),
                                    fontWeight: FontWeight.bold,fontFamily: 'Montserrat'),
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white,width: 1))
                                )
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 30,
                                padding: EdgeInsets.only(left: 15,right: 10),
                                alignment: Alignment.centerLeft,
                                child: Text('rua :'.toUpperCase(),style: TextStyle(color: Colors.white,
                                    fontWeight: FontWeight.bold,fontFamily: 'Montserrat')),
                              ),
                              Container(
                                height: 30,
                                width: MediaQuery.of(context).size.width*0.55,
                                alignment: Alignment.center,
                                padding: EdgeInsets.only(right: 10,left: 10),
                                child: TextField(
                                    controller: _controllerRua,
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.text,
                                    style: TextStyle(fontSize: 12,color: Color(0xff929090),
                                        fontWeight: FontWeight.bold,fontFamily: 'Montserrat'),
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.white,width: 1))
                                    )
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 30,
                                padding: EdgeInsets.only(left: 15,right: 10),
                                alignment: Alignment.centerLeft,
                                child: Text('número :'.toUpperCase(),style: TextStyle(color: Colors.white,
                                    fontWeight: FontWeight.bold,fontFamily: 'Montserrat')),
                              ),
                              Container(
                                height: 30,
                                width: MediaQuery.of(context).size.width*0.55,
                                alignment: Alignment.center,
                                padding: EdgeInsets.only(right: 10,left: 10),
                                child: TextField(
                                    controller: _controllerNumero,
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(fontSize: 12,color: Color(0xff929090),
                                        fontWeight: FontWeight.bold,fontFamily: 'Montserrat'),
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.white,width: 1))
                                    )
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 30,
                                padding: EdgeInsets.only(left: 15,right: 10),
                                alignment: Alignment.centerLeft,
                                child: Text('bairro :'.toUpperCase(),style: TextStyle(color: Colors.white,
                                    fontWeight: FontWeight.bold,fontFamily: 'Montserrat')),
                              ),
                              Container(
                                height: 30,
                                width: MediaQuery.of(context).size.width*0.55,
                                alignment: Alignment.center,
                                padding: EdgeInsets.only(right: 10,left: 10),
                                child: TextField(
                                    controller: _controllerBairro,
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.text,
                                    style: TextStyle(fontSize: 12,color: Color(0xff929090),
                                        fontWeight: FontWeight.bold,fontFamily: 'Montserrat'),
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.white,width: 1))
                                    )
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 30,
                                padding: EdgeInsets.only(left: 15,right: 10),
                                alignment: Alignment.centerLeft,
                                child: Text('cidade :'.toUpperCase(),style: TextStyle(color: Colors.white,
                                    fontWeight: FontWeight.bold,fontFamily: 'Montserrat')),
                              ),
                              Container(
                                height: 30,
                                width: MediaQuery.of(context).size.width*0.55,
                                alignment: Alignment.center,
                                padding: EdgeInsets.only(right: 10,left: 10),
                                child: TextField(
                                    controller: _controllerCidade,
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.text,
                                    style: TextStyle(fontSize: 12,color: Color(0xff929090),
                                        fontWeight: FontWeight.bold,fontFamily: 'Montserrat'),
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.white,width: 1))
                                    )
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 30,
                                padding: EdgeInsets.only(left: 15,right: 10),
                                alignment: Alignment.centerLeft,
                                child: Text('estado :'.toUpperCase(),style: TextStyle(color: Colors.white,
                                    fontWeight: FontWeight.bold,fontFamily: 'Montserrat')),
                              ),
                              Container(
                                height: 30,
                                width: MediaQuery.of(context).size.width*0.55,
                                alignment: Alignment.center,
                                padding: EdgeInsets.only(right: 10,left: 10),
                                child: TextField(
                                    controller: _controllerEstado,
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.text,
                                    style: TextStyle(fontSize: 12,color: Color(0xff929090),
                                        fontWeight: FontWeight.bold,fontFamily: 'Montserrat'),
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.white,width: 1))
                                    )
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 15,right: 10),
                                alignment: Alignment.centerRight,
                                child: Text('CEP :'.toUpperCase(),style: TextStyle(color: Colors.white,
                                    fontWeight: FontWeight.bold,fontFamily: 'Montserrat')),
                              ),
                              Container(
                                height: 30,
                                width: MediaQuery.of(context).size.width*0.55,
                                padding: EdgeInsets.only(right: 10,left: 10),
                                child: TextField(
                                    inputFormatters: [
                                      WhitelistingTextInputFormatter.digitsOnly,
                                      CepInputFormatter()
                                    ],
                                    controller: _controllerCEP,
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(fontSize: 12,color: Color(0xff929090),
                                        fontWeight: FontWeight.bold,fontFamily: 'Montserrat'),
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.white,width: 1))
                                    )
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 30,
                                padding: EdgeInsets.only(left: 15,right: 10),
                                alignment: Alignment.centerLeft,
                                child: Text('telefone :'.toUpperCase(),style: TextStyle(color: Colors.white,
                                    fontWeight: FontWeight.bold,fontFamily: 'Montserrat')),
                              ),
                              Container(
                                height: 30,
                                width: MediaQuery.of(context).size.width*0.55,
                                alignment: Alignment.center,
                                padding: EdgeInsets.only(right: 10,left: 10),
                                child: TextField(
                                    inputFormatters: [
                                      WhitelistingTextInputFormatter.digitsOnly,
                                      TelefoneInputFormatter()
                                    ],
                                    controller: _controllerTelefone,
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(fontSize: 12,color: Color(0xff929090),
                                        fontWeight: FontWeight.bold,fontFamily: 'Montserrat'),
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.white,width: 1))
                                    )
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 30,
                                padding: EdgeInsets.only(left: 15,right: 10),
                                alignment: Alignment.centerLeft,
                                child: Text('Apartamento :'.toUpperCase(),style: TextStyle(color: Colors.white,
                                    fontWeight: FontWeight.bold,fontFamily: 'Montserrat',fontSize: 10)),
                              ),
                              Container(
                                height: 30,
                                width: MediaQuery.of(context).size.width*0.55,
                                alignment: Alignment.center,
                                padding: EdgeInsets.only(right: 10,left: 10),
                                child: TextField(
                                    controller: _controllerAP,
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.text,
                                    style: TextStyle(fontSize: 12,color: Color(0xff929090),
                                        fontWeight: FontWeight.bold,fontFamily: 'Montserrat'),
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.white,width: 1))
                                    )
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 5,bottom: 5),
                            child: RaisedButton(
                              onPressed: (){
                                _validarCampos();
                              },
                              child: Text('Salvar Dados'.toUpperCase(),style: TextStyle(color: Colors.white),),
                              color: Color(0xff18656d),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.only(top: 5,right: 30,left: 30),
                    child: Center(
                      child: Text(
                        _mensagemErro,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 15
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 5,bottom: 30),
                  child: RaisedButton(
                    onPressed: () async {
                      if(_salvarDados){
                        setState(() {
                          _mensagemErro = "";
                        });
                        PaymentResult result =
                        await MercadoPagoMobileCheckout.startCheckout(
                          _publicKey,
                          _idPagamento,
                        );
                        if(result.status == "approved"){
                          _atualizarStatus();
                          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => Splash()));
                        }else{
                          setState(() {
                            _mensagemErro = "Pagamento não concluído";
                          });
                        }
                      }else{
                        setState(() {
                          _mensagemErro = "Salve os dados acima para continuar";
                        });
                      }

                    },
                    child: Text('Fazer Pagamento'.toUpperCase(),style: TextStyle(color: Colors.white),),
                    color: Color(0xff18656d),
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
