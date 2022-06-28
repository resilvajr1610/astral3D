import 'package:astrall/TelasIniciais/Home.dart';
import 'package:astrall/provider/google_sign_in.dart';
import 'package:astrall/Login/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginGoogle extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    body: ChangeNotifierProvider(
      create : (context) => GoogleSignInProvider(),
      child :StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (context,snapshot){
          final provider = Provider.of<GoogleSignInProvider>(context);

          if (provider.isSingingIn) {
            return buildLoading();
          } else if (snapshot.hasData) {
            return Home();
          }else{
            return Login();
          }
        }
      )
    ),
  );

  Widget buildLoading()=> Center(child: CircularProgressIndicator());
}

