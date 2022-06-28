import 'dart:convert';

import 'package:astrall/model/Comprar.dart';
import 'package:astrall/telasNavigation/Pedidos.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';

class PedidoCliente extends StatefulWidget {

  Comprar comprar;
  PedidoCliente(this.comprar);

  @override
  _PedidoClienteState createState() => _PedidoClienteState();
}

class _PedidoClienteState extends State<PedidoCliente> {

  Comprar _comprar;
  String _botaoStatus;
  String _token;

  @override
  void initState() {
    super.initState();
    _comprar = widget.comprar;
    _recuperarDadosUsuario();
    _recuperarDadosVendedor();
  }
  _recuperarDadosUsuario()async{

    Firestore db = Firestore.instance;
    DocumentSnapshot snapshot = await
    db.collection("comprar")
        .document(_comprar.idCompra)
        .get();
  }

  void launchWhats({@required number, @required message})async{
    String url = "whatsapp://send?phone=$number&text=$message";

    await canLaunch(url) ? launch(url) : print("Erro");
  }
  void launchGmail(String url)async{
    if(await canLaunch(url)){
      await launch(url, forceWebView: false,forceSafariVC: false);
    }else{
      print("Erro");
    }
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
  _atualizarStatus(){
    Firestore db = Firestore.instance;

    if(_comprar.status !=null){
      Map<String,dynamic> dadosAtualizar = {
        "status" : "produto recebido",
        "ok" : "pronto"
      };
      db.collection("comprar")
          .document(_comprar.idCompra)
          .updateData(dadosAtualizar);
      sendNotification([_comprar.tokenCliente],"Produto recebido!","Astral 3D");
    }
    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => Pedidos()));
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
  _dialogLiberar()async{
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text("Confirmação",textAlign: TextAlign.center),
            content: Text("Deseja confirmar recebimendo do seu produto ?"),
            actions: <Widget>[
              FlatButton(
                color: Colors.red,
                child: Text(
                  "Fechar",
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                color: Colors.green,
                child: Text(
                  "Iniciar",
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
                onPressed: (){
                  Navigator.of(context).pop();
                  _atualizarStatus();
                },
              )
            ],
          );
        }
    );
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
        decoration: BoxDecoration(
            color: Colors.black
        ),
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(20),
                    child: Container(
                      alignment: Alignment.topCenter,
                      decoration: BoxDecoration(
                          border: Border.all(width: 2,color: Colors.white)
                      ),
                      child: Flex(
                        direction: Axis.vertical,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(height: 5),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Text('Data : '.toUpperCase()+_comprar.data.toUpperCase(),style: TextStyle(color: Color(0xff929090)),),
                          ),
                          Divider(color: Colors.white,thickness: 2,),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Text('Produto : '.toUpperCase()+_comprar.produto.toUpperCase(),
                                  style: TextStyle(color: Color(0xff929090),fontSize: 12),),
                              ),
                              Spacer(),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Text('Material : '.toUpperCase()+_comprar.cor.toUpperCase(),
                                  style: TextStyle(color: Color(0xff929090),fontSize: 12),),
                              ),
                            ],
                          ),
                          Divider(color: Colors.white,thickness: 2,),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Text('status : '.toUpperCase()+_comprar.status.toUpperCase(),style: TextStyle(color: Color(0xff929090)),),
                          ),
                          Divider(color: Colors.white,thickness: 2,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Text('Dúvidas? fale conosco'.toUpperCase(),
                                  style: TextStyle(color: Color(0xff929090)),),
                              ),
                              GestureDetector(
                                onTap: (){
                                  launchWhats(number: "+557391055558", message: "Cliente :"+_comprar.nome+"\nProduto: "+_comprar.produto+"\nMaterial: "+_comprar.cor);
                                },
                                child: Image.asset(
                                  "assets/imagens/whats.png",
                                  alignment: Alignment.center,
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                              Container(width: 10),
                              GestureDetector(
                                onTap: (){
                                  launchGmail('mailto:renato10viana@hotmail.com');
                                },
                                child: Image.asset(
                                  "assets/imagens/gmail.png",
                                  alignment: Alignment.center,
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                            ],
                          ),
                          Container(height: 5),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 5,bottom: 5),
                    child: _comprar.status !="produto recebido" ? RaisedButton(
                      onPressed: (){
                        _dialogLiberar();
                      },
                      child: Text('Confirmar Recedimento do produto'.toUpperCase(),style: TextStyle(color: Colors.white),),
                      color: Color(0xff18656d),
                    ):Container(),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
