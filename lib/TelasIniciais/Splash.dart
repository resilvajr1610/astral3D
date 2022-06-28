import 'package:astrall/Login/LoginGoogle.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class Splash extends StatefulWidget {

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  Future<bool> _mockCheckForSession()async{
    await Future.delayed(Duration(milliseconds: 5000),(){});

    return true;
  }
  @override
  void initState() {
    super.initState();
    permissaoGaleria();

    _mockCheckForSession().then(
            (status) {
          if(status){
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: ( BuildContext context) => LoginGoogle()
                )
            );
          }
        }
    );
  }

  permissaoGaleria()async{

    var galeriaStatus = await Permission.accessMediaLocation.status;
    var notificacao = await Permission.notification.status;
    var imagem = await Permission.storage.status;
    var internet = await Permission.photos.status;

    if(!galeriaStatus.isGranted) await Permission.accessMediaLocation.request();
    if(!notificacao.isGranted) await Permission.notification.request();
    if(!imagem.isGranted) await Permission.storage.request();
    if(!internet.isGranted) await Permission.photos.request();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/imagens/splash.png"), fit: BoxFit.cover)),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: 250,),
                Container(
                  padding: EdgeInsets.all(5),
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(color: Colors.white),

                )
              ],
            ),
          )
      ),
    );
  }
}
