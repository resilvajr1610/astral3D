import 'dart:async';
import 'package:astrall/Itens/ItemPedidos.dart';
import 'package:astrall/model/Comprar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Pedidos extends StatefulWidget {

  @override
  _PedidosState createState() => _PedidosState();
}

class _PedidosState extends State<Pedidos> {

  final _controller = StreamController<QuerySnapshot>.broadcast();
  FirebaseAuth _auth;

  @override
  void initState() {
    super.initState();
    _adicionarListenerPedidos();
  }
  Future<Stream<QuerySnapshot>> _adicionarListenerPedidos()async{
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser usuarioLogado = await auth.currentUser();
    String idUsuarioLogado = usuarioLogado.uid;

    print("usuario : "+idUsuarioLogado.toString());

    Firestore db = Firestore.instance;
    Stream<QuerySnapshot> stream = db
        .collection("comprar")
        .where("idUsuario",isEqualTo: idUsuarioLogado)
        .where("ok",isEqualTo: "ok")
        .snapshots();

    stream.listen((dados) {
      _controller.add(dados);
    });
  }

  var carregandoDados = Center(
    child: Center(
      child: Column(children: <Widget>[
        Container(child: Text("Aguardando seus pedidos",style: TextStyle(color: Colors.white),)),
        CircularProgressIndicator()
      ],),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backwardsCompatibility: false,
        backgroundColor: Color(0xff101010),
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
            color: Color(0xff1a1a1b)
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(bottom: 10,top: 10),
                child: Text('Seus pedidos'.toUpperCase(),
                  style: TextStyle(color: Colors.white,
                      fontSize: 20,fontWeight: FontWeight.bold,fontFamily: 'Montserrat'),
                ),
              ),
              Expanded(
                child: StreamBuilder(
                  stream: _controller.stream,
                  builder: (context,snapshot){

                    switch (snapshot.connectionState){
                      case ConnectionState.none:
                        QuerySnapshot querySnapshot = snapshot.data;
                        return querySnapshot.documents.length ==0?
                           Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(child: Text("Faça seu pedido",style: TextStyle(color: Colors.white),)),
                              ],),
                          ):Container();
                          break;
                      case ConnectionState.waiting:
                        return carregandoDados;
                        break;
                      case ConnectionState.active:
                      case ConnectionState.done:

                      QuerySnapshot querySnapshot = snapshot.data;
                        if(querySnapshot.documents.length==0)
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(child: Text("Faça seu pedido!",style: TextStyle(color: Colors.white),)),
                              ],),
                          );
                        return ListView.builder(
                            itemCount: querySnapshot.documents.length,
                            itemBuilder: (_,indice){

                              List<DocumentSnapshot> perguntas = querySnapshot.documents.toList();
                              DocumentSnapshot documentSnapshot = perguntas[indice];
                              Comprar comprar = Comprar.fromDocumentSnapshot(documentSnapshot);

                              return ItemPedidos(
                                comprar: comprar,
                                onTapItem: (){
                                  Navigator.pushNamed(
                                      context,
                                      "/pedidos",
                                      arguments: comprar
                                  );
                                },
                              );
                            }
                        );
                    }
                    return Container();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
