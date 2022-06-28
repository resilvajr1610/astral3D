import 'dart:convert';
import 'package:astrall/model/Usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class GoogleSignInProvider extends ChangeNotifier{
  final googleSignIn = GoogleSignIn();
  bool _isSigningIn;
  String _token;

  GoogleSignInProvider(){
    _isSigningIn = false;
  }

  bool get isSingingIn => _isSigningIn;

  set isSingingIn(bool isSingingIn){
    _isSigningIn = isSingingIn;
    notifyListeners();
  }

  Future login() async{
    isSingingIn = true;

    final user = await googleSignIn.signIn();
    if(user == null){
      isSingingIn = false;
      return;
    } else {
      final googleAuth = await user.authentication;
      final credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      isSingingIn = false;

      var status = await OneSignal.shared.getDeviceState();
      _token = status.userId;
      sendNotification([_token],"Você está logado!","Astral 3D");
      _salvarOneSignal();

    }
  }

  void logout() async{
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }
  _salvarOneSignal()async{
    Usuario usuario = Usuario();
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser usuarioLogado = await auth.currentUser();
    String idUsuarioLogado = usuarioLogado.uid;
    usuario.idOneSignal = _token;

    Firestore db = Firestore.instance;
    db.collection("usuarios")
        .document(idUsuarioLogado)
        .setData(usuario.toSignal());
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

}