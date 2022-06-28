import 'package:astrall/telasNavigation/Pedidos.dart';
import 'package:astrall/telasNavigation/Sobre.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../telasNavigation/Conta.dart';
import '../telasNavigation/Inicio.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _indiceAtual = 0;

  @override
  Widget build(BuildContext context) {

    List<Widget> telas = [
      Sobre(),
      Inicio(),
      Pedidos(),
      Conta()
    ];

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/imagens/bgSobre2.png"), fit: BoxFit.cover)),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: telas[_indiceAtual],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xff101010),
        currentIndex: _indiceAtual,
        onTap: (indice){
          setState(() {
            _indiceAtual = indice;
          });
        },
        type: BottomNavigationBarType.fixed,
        fixedColor: Color(0xff08fef1),
        unselectedItemColor: Color(0xff18656d),
        items: [
          BottomNavigationBarItem(
            //backgroundColor: Colors.red,
              label: "Sobre",
              icon: Icon(MdiIcons.alertCircleOutline)
          ),
          BottomNavigationBarItem(
            //backgroundColor: Colors.orange,
              label: "Home",
              icon: Icon(MdiIcons.homeCircleOutline)
          ),
          BottomNavigationBarItem(
            //backgroundColor: Colors.blue,
              label: "Pedidos",
              icon: Icon(MdiIcons.compassOutline)
          ),
          BottomNavigationBarItem(
            //backgroundColor: Colors.green,
              label: "Conta",
              icon: Icon(Icons.person_outline)
          ),
        ],
      ),
    );
  }
}
