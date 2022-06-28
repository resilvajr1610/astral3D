import 'package:astrall/telasHome/ArtAction.dart';
import 'package:astrall/telasHome/Copia.dart';
import 'package:astrall/telasHome/Crie.dart';
import 'package:astrall/telasHome/GameMood.dart';
import 'package:astrall/telasHome/Memes.dart';
import 'package:astrall/telasHome/Miniatura.dart';
import 'package:astrall/telasHome/VoceHeroi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../Slides/Slide_tile.dart';

class Inicio extends StatefulWidget {

  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {

  final PageController _pageController = PageController(viewportFraction: 0.8);

  int _currentPage = 0;
  int _next =0;
  var _listSlide = [
    {'id':0, 'image':'assets/imagens/home1.png','titulo':'art action'},
    {'id':1, 'image':'assets/imagens/home2.png','titulo':'game mood'},
    {'id':2, 'image':'assets/imagens/home3.png','titulo':'você herói'},
    {'id':3, 'image':'assets/imagens/home4.png','titulo':'crie'},
    {'id':4, 'image':'assets/imagens/home5.png','titulo':'cópia'},
    {'id':5, 'image':'assets/imagens/home6.png','titulo':'miniatura'},
    {'id':6, 'image':'assets/imagens/home7.png','titulo':'memes'}
  ];

  @override
  void initState() {
    super.initState();
    permissaoGaleria();
    _pageController.addListener((){
      _next = _pageController.page.round();
      if(_currentPage != _next){
        setState(() {
          _currentPage = _next;
        });
      }
    });
  }

  permissaoGaleria()async{

    var galeriaStatus = await Permission.accessMediaLocation.status;
    var notificacao = await Permission.notification.status;
    var imagem = await Permission.storage.status;
    var internet = await Permission.photos.status;

    if(!galeriaStatus.isGranted)
      await Permission.accessMediaLocation.request();
    if(!notificacao.isGranted)
      await Permission.notification.request();
    if(!imagem.isGranted)
      await Permission.storage.request();
    if(!internet.isGranted)
      await Permission.photos.request();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backwardsCompatibility: false,
        backgroundColor: Colors.black,
        title: Image.asset(
          "assets/imagens/logo.png",
          alignment: Alignment.center,
          width: 120,
          height: 80,
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/imagens/bgHome.png"), fit: BoxFit.cover)),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SafeArea(
          child: Container(
            height: 400,
            child: Column(
              children: [
                Expanded(
                    child: PageView.builder(
                        controller: _pageController,
                        itemCount: _listSlide.length,
                        itemBuilder: (_,int currentIndex){
                          bool activePage = currentIndex ==_currentPage;
                          return SlideTile(
                            onTap: (){
                              _next = _currentPage.round();
                              print("index : "+_next.toString());
                              switch (_next){
                                case 0:
                                  return Navigator.push(context,MaterialPageRoute(builder: (context) => ArtAction()));
                                  break;
                                case 1:
                                  return Navigator.push(context,MaterialPageRoute(builder: (context) => GameMood()));
                                  break;
                                case 2:
                                  return Navigator.push(context,MaterialPageRoute(builder: (context) => VoceHeroi()));
                                  break;
                                case 3:
                                  return Navigator.push(context,MaterialPageRoute(builder: (context) => Crie()));
                                  break;
                                case 4:
                                  return Navigator.push(context,MaterialPageRoute(builder: (context) => Copia()));
                                  break;
                                case 5:
                                  return Navigator.push(context,MaterialPageRoute(builder: (context) => Miniatura()));
                                  break;
                                case 6:
                                  return Navigator.push(context,MaterialPageRoute(builder: (context) => Memes()));
                                  break;
                              }
                            },
                            titulo: _listSlide[currentIndex]['titulo'],
                            activePage : activePage,
                            image: _listSlide[currentIndex]['image']
                          );
                        }
                    )
                ),
                _buildBullets()
              ],
            ),
          )
        ),
      ),
    );
  }

  Widget _buildBullets() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _listSlide.map((i) {
          return InkWell(
            onTap: (){
              setState(() {
                _pageController.jumpToPage(i['id']);
                _currentPage = i['id'];
              });
            },
            child: Container(
              margin: EdgeInsets.all(5),
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                  color:_currentPage == i['id']? Color(0xff08fef1): Color(0xff18656d),
              ),
            ),
          );
        }).toList()
      ),
    );
  }
}
