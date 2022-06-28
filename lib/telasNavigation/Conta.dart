import 'package:astrall/provider/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Login/LoginGoogle.dart';

class Conta extends StatefulWidget {

  @override
  _ContaState createState() => _ContaState();
}

class _ContaState extends State<Conta> {

  String _foto;
  String _email;
  String _nome;
  FirebaseAuth _auth;

  _dadosUsuarios()async{
    _auth = FirebaseAuth.instance;
    FirebaseUser _usuarioLogado = await _auth.currentUser();
    _foto = _usuarioLogado.photoUrl;
    _email = _usuarioLogado.email;
    _nome = _usuarioLogado.displayName;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _dadosUsuarios();
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
        child: Container(
            alignment: Alignment.center,
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _foto !=null?
                CircleAvatar(
                  maxRadius: 40,
                  backgroundImage: _foto != null ?NetworkImage(_foto):AssetImage("assets/imagens/bgSobre2.png"),
                ):Container(),
                SizedBox(height: 8,),
                _nome == null ? Container():
                Text('Olá, ' + _nome,style: TextStyle(color: Colors.white,fontFamily: 'Montserrat'),),
                SizedBox(height: 8),
                _email == null ? Container():
                //Text('E-mail : ' + _email,style: TextStyle(color: Colors.white),),
                SizedBox(height: 16,),
                RaisedButton(
                    color: Color(0xff373739),
                    onPressed: (){
                      if(_foto!=null){
                        final provider =
                        Provider.of<GoogleSignInProvider>(context, listen: false);
                        provider.logout();
                      }else{
                        _auth.signOut();
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: ( BuildContext context) => LoginGoogle()
                            )
                        );
                      }
                    },
                    child: Text('Sair'.toUpperCase(),style: TextStyle(color: Colors.white,fontFamily: 'Montserrat'),)
                )
              ],
            )
        ),
      ),
    );
  }
}
