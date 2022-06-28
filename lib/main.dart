import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'RouteGenerator.dart';
import 'TelasIniciais/Splash.dart';

final ThemeData temaPadrao = ThemeData(
  primaryColor:Color(0xff61aef5),
  secondaryHeaderColor: Color(0xffF1F5F4),
  accentColor:Color(0xff748d9b),

);

void main(){
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
    //theme: temaPadrao,
    onGenerateRoute: RouteGenerator.generateRoute,
    debugShowCheckedModeBanner: false,
    home: Splash(),
  ));
  OneSignal.shared.setAppId('6644a269-17ee-446b-9fd7-3cf0cece0901');
}