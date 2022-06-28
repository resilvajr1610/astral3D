import 'package:astrall/TelasIniciais/Cadastro.dart';
import 'package:astrall/model/Usuario.dart';
import 'package:astrall/provider/google_sign_in.dart';
import 'package:astrall/Login/LoginEmail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import 'LoginGoogle.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/imagens/bgLogin1.png"), fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: RaisedButton(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset("assets/imagens/google.png",
                            width: 20,
                            height: 20,
                          ),
                          SizedBox(width: 10,),
                          Text(
                            "Entrar com o google".toUpperCase(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xff222222),
                                fontSize: 16,
                                fontFamily: 'Rosario'),
                          ),
                        ],
                      ),
                      color: Colors.white,
                      elevation: 5,
                      padding: EdgeInsets.fromLTRB(32, 9, 32, 9),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      onPressed: () {
                        final provider =
                            Provider.of<GoogleSignInProvider>(context,listen:false);
                        provider.login();
                      }),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 0),
                  child: RaisedButton(
                      child: Text(
                        "   Cadastre-se pelo e-mail   ".toUpperCase(),
                        style: TextStyle(
                            color: Color(0xff222222),
                            fontSize: 16,
                            fontFamily: 'Rosario'),
                      ),
                      color: Colors.white,
                      elevation: 5,
                      padding: EdgeInsets.fromLTRB(32, 9, 32, 9),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Cadastro()
                            )
                        );
                      }),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginEmail()
                        )
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'Já tem conta? Entrar',
                      style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(height: 40,)
              ],
        ),
      ),
    );
  }
}
