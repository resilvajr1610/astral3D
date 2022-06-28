import 'dart:async';
import 'package:astrall/checkouts/CheckGame.dart';
import 'package:astrall/model/Comprar.dart';
import 'package:astrall/model/Cor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import '../Slides/SlideAction.dart';
import '../Slides/SlideDuvidas.dart';

class GameMood extends StatefulWidget {
  const GameMood({Key key}) : super(key: key);

  @override
  _GameMoodState createState() => _GameMoodState();
}

class _GameMoodState extends State<GameMood> {

  String _idUsuarioLogado;
  String _mensagemErro = "";
  String _de,_por,_porSoma,_branco,_preto,_pintado;
  List<DropdownMenuItem<String>> _listaItensDropCores;
  double _precoCor;
  String _itemSelecionadoCor;
  int _next =0;
  int _currentPage = 0;
  Comprar _idCompra;
  final PageController _pageController = PageController(viewportFraction: 0.8);

  double _favoritos = 5;

  var _listWhats = [
    {'id':0, 'image':'assets/imagens/game4.png'},
    {'id':1, 'image':'assets/imagens/game5.png'}
  ];

  var _listDuvidas = [
    {'id':0, 'titulo':'Após minha compra, qual o prazo de entrega?','corpo':'O prazo para fabricação são de 6 dias úteis, e o tempo da entrega varia conforme sua região, mas a média são 10 dias úteis.'},
    {'id':1, 'titulo':'O que eu devo mandar?','corpo':'Após clicar em adquirir, é só seguir os passos  das posições das fotos do objeto que deseja fazer a cópia.'},
    {'id':2, 'titulo':'Como acompanhar meu pedido?','corpo':'Após a compra, nós enviaremos mensagens para você por whatsapp ou e-mail, e se tiver alguma outra dúvida, pode mandar mensagem para nosso Whatsapp: 73 9 91055558.'},
    {'id':3, 'titulo':'Material e tamanho','corpo':'Nossas produções são feitas de filamento PLA de alta qualidade para máquinas de impressão 3D, e o tamanho aproximado da peça é de 100 x 100 mm para tamanhos médios e 200 x 200 mm para tamanhos grandes.'}
  ];

  int _tempoContagemRegressiva = 0;
  int _tempoPromocao = 1058;
  String _tempoDisplay = "";

  _carregarItensDropdown(){
    _listaItensDropCores = Cor.getCores();
  }

  @override
  void initState() {
    super.initState();
    _idCompra= Comprar.gerarId();
    _recuperarDadosUsuario();
    iniciar();
    _recuperarDadosArt();
    _carregarItensDropdown();
    _pageController.addListener((){
      _next = _pageController.page.round();
      if(_currentPage != _next){
        setState(() {
          _currentPage = _next;
        });
      }
    });
  }
  _recuperarDadosUsuario()async{

    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser usuarioLogado = await auth.currentUser();
    _idUsuarioLogado = usuarioLogado.uid;
  }

  iniciar(){
    _tempoContagemRegressiva = (_tempoPromocao*60);
    Timer.periodic(Duration(
      seconds: 1,
    ), (Timer t){
      setState(() {
        if(_tempoContagemRegressiva<1 ){
          t.cancel();
          _tempoDisplay = "";
        }
        else if(_tempoContagemRegressiva <60){
          _tempoDisplay = _tempoContagemRegressiva.toString();
          _tempoContagemRegressiva = _tempoContagemRegressiva - 1;
        }else if (_tempoContagemRegressiva<3600){
          int m = _tempoContagemRegressiva ~/60;
          int s = _tempoContagemRegressiva - ( 60 *m);
          _tempoDisplay = m.toString() + ":" + s.toString();
          _tempoContagemRegressiva = _tempoContagemRegressiva -1;
        } else{
          int h = _tempoContagemRegressiva ~/3600;
          int t = _tempoContagemRegressiva - (3600 * h);
          int m = t ~/60;
          int s = t - (60 * m);
          _tempoDisplay = h.toString() + ":" + m.toString() + ":" + s.toString();
          _tempoContagemRegressiva = _tempoContagemRegressiva-1;
        }
      });
    });
  }
  _recuperarDadosArt()async {
    Firestore db = Firestore.instance;
    DocumentSnapshot snapshot = await
    db.collection("produtos")
        .document("game")
        .get();

    Map<String, dynamic> dados = snapshot.data;
    setState(() {
      _de = dados["de"].toString();
      _de = _de.replaceAll(".", ",");
      _por = dados["por"].toString();
      _porSoma = dados["por"].toString();
      _por = _por.replaceAll(".", ",");
      _branco = dados["branco"].toString();
      _preto = dados["preto"].toString();
      _pintado = dados["pintado"].toString();
    });
  }

  Future<Stream<QuerySnapshot>> _corSelecionada ()async{

    if(_itemSelecionadoCor == "branco"){
      _por = _porSoma;
      _por = _por.replaceAll(",", ".");
      var por = double.parse(_por);
      var cor = double.parse(_branco);
      _precoCor = por + cor;
      _por = _precoCor.toString();
      _por = _por.replaceAll(".", ",");
      print("valor : "+_precoCor.toString());
      setState(() {
      });
    }
    if(_itemSelecionadoCor == "preto"){
      _por = _porSoma;
      _por = _por.replaceAll(",", ".");
      var por = double.parse(_por);
      var cor = double.parse(_preto);
      _precoCor = por + cor;
      _por = _precoCor.toString();
      _por = _por.replaceAll(".", ",");
      print("valor : "+_precoCor.toString());
      setState(() {
      });
    }
    if(_itemSelecionadoCor == "pintado"){
      _por = _porSoma;
      _por = _por.replaceAll(",", ".");
      var por = double.parse(_por);
      var cor = double.parse(_pintado);
      _precoCor = por + cor;
      _por = _precoCor.toString();
      _por = _por.replaceAll(".", ",");
      print("valor : "+_precoCor.toString());
      setState(() {
      });
    }
    if(_itemSelecionadoCor!= "pintado" && _itemSelecionadoCor!= "preto"&& _itemSelecionadoCor!= "branco"){
      _por = _porSoma;
      _por = _por.replaceAll(".", ",");
      print("valor : "+_por.toString());
      setState(() {
      });
    }
  }
  _produtoSelecionado(){

    if(_itemSelecionadoCor== "pintado" || _itemSelecionadoCor== "preto"|| _itemSelecionadoCor== "branco"){
      setState(() {
        _mensagemErro = "";
      });
      _por = _por.replaceAll(",", ".");
      Comprar comprar = Comprar();
      comprar.idUsuario = _idUsuarioLogado;
      comprar.cor = _itemSelecionadoCor;
      comprar.produto = "game";
      comprar.preco = _por;

      Firestore db = Firestore.instance;
      db.collection("comprar")
          .document(_idCompra.idCompra)
          .setData(comprar.toMap());

      Navigator.pushNamed(context,"/game",arguments: _idCompra.idCompra);

    }else{
      setState(() {
        _mensagemErro = "Selecione uma cor para avançar";
      });
    }
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
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.black
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                "assets/imagens/game1.png",
                fit: BoxFit.cover,
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                height: 180,
              ),
              Container(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10,top: 8),
                      child: Text(
                        "GAME MOOD".toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 25,
                            fontFamily: 'Anton'),
                      ),
                    ),
                    Spacer(),
                    Container(
                      child: SmoothStarRating(
                        size: 20,
                        color: Color(0xfff9a72b),
                        borderColor: Color(0xfff9a72b),
                        isReadOnly: true,
                        starCount: 5,
                        rating: _favoritos,
                        onRated: (valor){
                          setState(() {
                          });
                        },
                      ),
                      alignment: Alignment.topRight,
                    ),
                    Container(
                        padding: EdgeInsets.only(right: 10,left: 5),
                        child: Text('( 189 )',style: TextStyle(color: Colors.white,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold),)
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Container(
                      child: Text('em promoção'.toUpperCase(),style: TextStyle(color: Colors.white,fontFamily: 'Montserrat',),),
                      color: Color(0xffff1616),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(_de!=null?"R\$ "+_de.toString():"R\$ 0,00",style: TextStyle(
                          decoration: TextDecoration.lineThrough,decorationColor: Color(0xffff1616),
                          color: Color(0xff929090))),
                    ),
                  ],
                ),
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 10,top: 10),
                  child: Text(_por!=null?"R\$ "+_por.toString():"R\$ 0,00",style: TextStyle(color: Colors.white,
                      fontFamily: 'Montserrat',
                      fontSize: 20,
                      fontWeight: FontWeight.bold))
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.access_time,color:Color(0xfff9a72b),),
                    Container(
                      child: Text(
                        " 2d - "+ _tempoDisplay,style: TextStyle(
                          fontSize: 15,
                          color: Color(0xfff9a72b),
                          fontWeight: FontWeight.w600
                      ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 10,top: 5),
                  child: Text("Apenas as últimas 6 produções nesse valor".toUpperCase(),style: TextStyle(color: Colors.white,
                      fontFamily: 'Montserrat',
                      fontSize: 10,
                      fontWeight: FontWeight.bold))
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 10,top: 10),
                child: Text('Material - Cor',style: TextStyle(
                    color: Color(0xff929090),fontSize: 15)),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Container(
                  alignment: Alignment.center,
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xff929090),width: 2,
                      )
                  ),
                  padding: EdgeInsets.only(left: 30,top: 5,right: 30,bottom: 5),
                  child: Container(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          iconEnabledColor: Color(0xff929090),
                          value: _itemSelecionadoCor,
                          items: _listaItensDropCores,
                          style: TextStyle(
                              fontSize: 22,
                              color: Color(0xff929090)
                          ),
                          onChanged: (categoria){
                            setState(() {
                              _itemSelecionadoCor = categoria;
                              _corSelecionada();
                            });
                          },
                        ),
                      )
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5),
                child: Center(
                  child: Text(
                    _mensagemErro,
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 15
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    RaisedButton(
                        color: Color(0xff099590),
                        child: Container(
                          child: Text('Adquirir'.toUpperCase(),style: TextStyle(
                              color: Colors.white,fontFamily: 'Anton',fontSize: 25),),
                        ),
                        onPressed: (){
                          _produtoSelecionado();
                        }
                    ),
                  ],
                ),
              ),
              Image.asset(
                "assets/imagens/pagamento.png",
                fit: BoxFit.fitHeight,
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                height: 30,
              ),
              Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Text('ETERNIZE SUA SKIN',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,),)
              ),
              Flexible(
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.all(20),
                  child: Text('Mande fotos da sua Skin após clicar em "ADQUIRIR", e daremos vida a ela na máquina 3D em um linda Miniatura.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xff929090),
                        fontSize: 12,fontWeight: FontWeight.w900,fontFamily: 'Montserrat'),
                  ),
                ),
              ),
              Image.asset(
                "assets/imagens/game2.png",
                fit: BoxFit.fitHeight,
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                height: 180,
              ),
              Container(height: 15,),
              Image.asset(
                "assets/imagens/game3.png",
                fit: BoxFit.fitHeight,
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                height: 180,
              ),
              Container(height: 10,),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 20,bottom: 10),
                child: Text('Como funciona?',textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.white,
                      fontSize: 20,fontWeight: FontWeight.bold,fontFamily: 'Montserrat'),
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 10),
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 20,top: 10),
                      child: Text('1',textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white,
                            fontSize: 40,fontWeight: FontWeight.w900,fontFamily: 'Montserrat'),
                      ),
                    ),
                    Flexible(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 20,top: 10),
                        child: Text('Após clicar no botão "ADQUIRIR" você será orientado para o envio da foto, e ao finalizar o pagamento você poderá acompanhar seu pedido em "pedidos" na barra inferior',
                          textAlign: TextAlign.justify,
                          style: TextStyle(color: Color(0xff929090),
                              fontSize: 9,fontWeight: FontWeight.bold,fontFamily: 'Montserrat'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 10),
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 20,top: 10),
                      child: Text('2',textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white,
                            fontSize: 40,fontWeight: FontWeight.bold,fontFamily: 'Montserrat'),
                      ),
                    ),
                    Flexible(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 20,top: 10),
                        child: Text('Após recebermos sua foto, o Softawe irá fazer a conversão da fotos para um modelo 3D e encaminhado para a impressora 3D, onde seu objeto tomará vida.',
                          textAlign: TextAlign.justify,
                          style: TextStyle(color: Color(0xff929090),
                              fontSize: 9,fontWeight: FontWeight.w900,fontFamily: 'Montserrat'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 10),
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 20,top: 10),
                      child: Text('3',textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white,
                            fontSize: 40,fontWeight: FontWeight.bold,fontFamily: 'Montserrat'),
                      ),
                    ),
                    Flexible(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 20,top: 10),
                        child: Text('Após a criação do seu objeto, embalaremos e enviaremos para o endereço informado, e em alguns dias chegará na sua casa.',
                          textAlign: TextAlign.justify,
                          style: TextStyle(color: Color(0xff929090),
                              fontSize: 9,fontWeight: FontWeight.w900,fontFamily: 'Montserrat'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(height: 10,),
              Image.asset(
                "assets/imagens/gif.gif",
                fit: BoxFit.fitWidth,
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                height: 200,
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(left: 15,bottom: 10,top: 20, right: 15),
                child: Text('Quem já comprou recomenda'.toUpperCase(),textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white,
                      fontSize: 16,fontWeight: FontWeight.bold,fontFamily: 'Montserrat'),
                ),
              ),
              Container(
                height: 200,
                child: Container(
                    child: PageView.builder(
                        controller: _pageController,
                        itemCount: _listWhats.length,
                        itemBuilder: (_,int currentIndex){
                          return SlideAction(
                              image: _listWhats[currentIndex]['image']
                          );
                        }
                    )
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(left: 15,bottom: 10,top: 20, right: 15),
                child: Text('Dúvidas Frequentes'.toUpperCase(),textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white,
                      fontSize: 16,fontWeight: FontWeight.bold,fontFamily: 'Montserrat'),
                ),
              ),
              Container(
                height: 190,
                child: Container(
                    child: PageView.builder(
                        controller: _pageController,
                        itemCount: _listDuvidas.length,
                        itemBuilder: (_,int currentIndex){
                          return SlideDuvidas(
                            titulo: _listDuvidas[currentIndex]['titulo'],
                            corpo: _listDuvidas[currentIndex]['corpo'],
                          );
                        }
                    )
                ),
              ),
              Row(
                children: [
                  Image.asset(
                    "assets/imagens/estrela.png",
                    fit: BoxFit.fitHeight,
                    alignment: Alignment.topLeft,
                    height: 150,
                  ),
                  Column(
                    children: [
                      Container(
                        alignment: Alignment.topCenter,
                        padding: EdgeInsets.only(left: 15,bottom: 10, right: 15),
                        child: Text('GANHE FRETE GRÁTIS'.toUpperCase(),textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white,
                              fontSize: 12,fontWeight: FontWeight.bold,fontFamily: 'Montserrat'),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 0,top: 10),
                        child: Text('Ao clicar em adquirir e depois que\n realizar a compra, basta avaliar nosso\n aplicativo em 5 estrelas e enviar para 3\n amigos, e mandar print para nosso\n e-mail: astral3dapp@gmail.com ou\n para nosso WhatsApp: 73 9 91055558.\nE pronto, o Frete Grátis é seu.',
                          textAlign: TextAlign.right,
                          style: TextStyle(color: Color(0xff929090),
                              fontSize: 9,fontWeight: FontWeight.w900,fontFamily: 'Montserrat'),
                        ),
                      ),
                      Container(height: 20),
                    ],
                  ),
                ],
              ),
              Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(left: 10,bottom: 10, right: 10,top: 20),
                child: Text('clique em adquirir e FAÇA PARTE do futuro'.toUpperCase(),textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white,
                      fontSize: 11,fontWeight: FontWeight.bold,fontFamily: 'Montserrat'),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 10,top: 10),
                child: Text('Material - Cor',style: TextStyle(
                    color: Color(0xff929090),fontSize: 15)),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Container(
                  alignment: Alignment.center,
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xff929090),width: 2,
                      )
                  ),
                  padding: EdgeInsets.only(left: 30,top: 5,right: 30,bottom: 5),
                  child: Container(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          iconEnabledColor: Color(0xff929090),
                          value: _itemSelecionadoCor,
                          items: _listaItensDropCores,
                          style: TextStyle(
                              fontSize: 22,
                              color: Color(0xff929090)
                          ),
                          onChanged: (categoria){
                            setState(() {
                              _itemSelecionadoCor = categoria;
                              _corSelecionada();
                            });
                          },
                        ),
                      )
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    RaisedButton(
                        color: Color(0xff099590),
                        child: Container(
                          child: Text('Adquirir'.toUpperCase(),style: TextStyle(
                              color: Colors.white,fontFamily: 'Anton',fontSize: 25),),
                        ),
                        onPressed: (){
                          _produtoSelecionado();
                        }
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
