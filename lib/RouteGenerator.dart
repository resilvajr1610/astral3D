import 'package:astrall/checkouts/CheckArt.dart';
import 'package:astrall/checkouts/CheckCopia.dart';
import 'package:astrall/checkouts/CheckCrie.dart';
import 'package:astrall/checkouts/CheckGame.dart';
import 'package:astrall/checkouts/CheckMemes.dart';
import 'package:astrall/checkouts/CheckMiniatura.dart';
import 'package:astrall/checkouts/CheckVoce.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'TelasIniciais/PedidoCliente.dart';

class RouteGenerator{

    static Route<dynamic> generateRoute(RouteSettings settings){
      final args = settings.arguments;

      switch(settings.name){
        case "/art" :
          return MaterialPageRoute(
              builder: (_) => CheckArt(args)
          );
        case "/copia" :
          return MaterialPageRoute(
              builder: (_) => CheckCopia(args)
          );
        case "/crie" :
          return MaterialPageRoute(
              builder: (_) => CheckCrie(args)
          );
        case "/game" :
          return MaterialPageRoute(
              builder: (_) => CheckGame(args)
          );
        case "/memes" :
          return MaterialPageRoute(
              builder: (_) => CheckMemes(args)
          );
        case "/mini" :
          return MaterialPageRoute(
              builder: (_) => CheckMiniatura(args)
          );
        case "/voce" :
          return MaterialPageRoute(
              builder: (_) => CheckVoce(args)
          );
        case "/pedidos" :
          return MaterialPageRoute(
              builder: (_) => PedidoCliente(args)
          );

        default :
          _erroRota();
      }
    }
    static  Route <dynamic> _erroRota(){
      return MaterialPageRoute(
          builder:(_){
            return Scaffold(
              appBar: AppBar(
                title: Text("Tela não encontrada"),
              ),
              body: Center(
                child: Text("Tela não encontrada"),
              ),
            );
          });
    }
  }