import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'Inicio.dart';

class Sobre extends StatefulWidget {

  @override
  _SobreState createState() => _SobreState();
}

class _SobreState extends State<Sobre> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/imagens/bgSobre2.png"), fit: BoxFit.cover)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.all(0),
                child: Image.asset(
                  "assets/imagens/bgSobre1.1.png",
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  fit: BoxFit.fill,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16,left: 30,right: 30),
                child: Text(
                  "A Astral 3D é uma empresa de fabricação de coisas feitas em tecnologia 3D,  que torna o seu sonho, realidade.".toUpperCase(),
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      color: Color(0xffffffff),
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Montserrat'),
                ),
              ),
              Image.asset(
                "assets/imagens/linha.png",
                alignment: Alignment.center,
                width: 280,
                height: 40,
              ),
              Row(
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width/3.5),
                  Padding(
                    padding: const EdgeInsets.only(top: 16,left: 20,right: 20),
                    child: Text(
                      "CRIE".toUpperCase(),
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          color: Color(0xffffffff),
                          fontWeight: FontWeight.w900,
                          fontSize: 40,
                          fontFamily: 'Rosaria'),
                    ),
                  ),
                  Image.asset(
                    "assets/imagens/sobre1.png",
                    alignment: Alignment.centerRight,
                    width: 98,
                    height: 98,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16,left: 19,right: 19),
                child: Text(
                  "Desenhou um personagem e quer vê-lo materializado fisicamente?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xff929090),
                      fontSize: 14,
                      fontFamily: 'Montserrat'),
                ),
              ),
              Image.asset(
                "assets/imagens/sobre2.png",
                alignment: Alignment.center,
                width: 300,
                height: 150,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16,left: 19,right: 19),
                child: Text(
                  "Nos envie uma foto, um desenho ou seu projeto de impressão que a Astral 3D dará vida ao que você tanto sonha!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xff929090),
                      fontSize: 14,
                      fontFamily: 'Montserrat'),
                ),
              ),
              Image.asset(
                "assets/imagens/linha.png",
                alignment: Alignment.center,
                width: 280,
                height: 40,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16,left: 20,right: 20),
                  child: Text(
                    "game mood".toUpperCase(),
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        color: Color(0xffffffff),
                        fontWeight: FontWeight.w900,
                        fontSize: 25,
                        fontFamily: 'Rosaria'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16,left: 19,right: 19),
                child: Text(
                  "Tenha sua skin ou o personagem do seu jogo favorito materializado no mundo real.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xff929090),
                      fontSize: 14,
                      fontFamily: 'Montserrat'),
                ),
              ),
              Image.asset(
                "assets/imagens/sobre3.png",
                alignment: Alignment.center,
                width: 300,
                height: 150,
              ),
              Image.asset(
                "assets/imagens/linha.png",
                alignment: Alignment.center,
                width: 280,
                height: 40,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16,left: 20,right: 20),
                  child: Text(
                    "art action".toUpperCase(),
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        color: Color(0xffffffff),
                        fontWeight: FontWeight.w900,
                        fontSize: 25,
                        fontFamily: 'Rosaria'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16,left: 19,right: 19),
                child: Text(
                  "Dê a vida a um ator ou personagem da sua série, banda ou filme favorito.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xff929090),
                      fontSize: 14,
                      fontFamily: 'Montserrat'),
                ),
              ),
              Image.asset(
                "assets/imagens/sobre4.png",
                alignment: Alignment.center,
                width: 300,
                height: 150,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16,left: 20,right: 20),
                  child: Text(
                    "cópia".toUpperCase(),
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        color: Color(0xffffffff),
                        fontWeight: FontWeight.w900,
                        fontSize: 25,
                        fontFamily: 'Rosaria'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16,left: 19,right: 19),
                child: Text(
                  "Recrie qualquer objeto que quiser.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xff929090),
                      fontSize: 14,
                      fontFamily: 'Montserrat'),
                ),
              ),
              Image.asset(
                "assets/imagens/sobre5.png",
                alignment: Alignment.center,
                width: 300,
                height: 150,
              ),
              Image.asset(
                "assets/imagens/linha.png",
                alignment: Alignment.center,
                width: 280,
                height: 40,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16,left: 20,right: 20),
                  child: Text(
                    "miniatura".toUpperCase(),
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        color: Color(0xffffffff),
                        fontWeight: FontWeight.w900,
                        fontSize: 25,
                        fontFamily: 'Rosaria'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16,left: 19,right: 19),
                child: Text(
                  "Deseja ter uma miniatura sua, de alguém conhecido ou de seu pet?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xff929090),
                      fontSize: 14,
                      fontFamily: 'Montserrat'),
                ),
              ),
              Image.asset(
                "assets/imagens/sobre6.png",
                alignment: Alignment.center,
                width: 300,
                height: 150,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16,left: 19,right: 19),
                child: Text(
                  "Nós da Astral 3D criamos uma miniatura feita somente para você. Nos envie uma foto de corpo inteiro: frente, lado, costas (de preferência com uma boa luminosidade), e rapidinho chegará em seu endereço.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xff929090),
                      fontSize: 14,
                      fontFamily: 'Montserrat'),
                ),
              ),
              Image.asset(
                "assets/imagens/linha.png",
                alignment: Alignment.center,
                width: 280,
                height: 40,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16,left: 20,right: 20),
                  child: Text(
                    "Você herói".toUpperCase(),
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        color: Color(0xffffffff),
                        fontWeight: FontWeight.w900,
                        fontSize: 25,
                        fontFamily: 'Rosaria'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16,left: 19,right: 19),
                child: Text(
                  "Já pensou em ter como decoração, um incrivel personagem com o seu rosto? ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xff929090),
                      fontSize: 14,
                      fontFamily: 'Montserrat'),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Image.asset(
                      "assets/imagens/sobre7.png",
                      alignment: Alignment.centerRight,
                      width: 160,
                      height: 180,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16,left: 5,right: 5),
                    child: Text(
                      "Dê aquele presente para o \nHerói ou Heroina da sua \nvida, com o rosto dele(a). \nCom a tecnologia de \nsoftware e modelagem da \nAstral 3D, seus presentes \nserão os mais incríveis e \ncriativos de todos. ",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Color(0xff929090),
                          fontSize: 10,
                          fontFamily: 'Montserrat'),
                    ),
                  ),
                ],
              ),
              Image.asset(
                "assets/imagens/linha.png",
                alignment: Alignment.center,
                width: 280,
                height: 40,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16,left: 20,right: 20),
                  child: Text(
                    "memes".toUpperCase(),
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        color: Color(0xffffffff),
                        fontWeight: FontWeight.w900,
                        fontSize: 25,
                        fontFamily: 'Rosaria'),
                  ),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Image.asset(
                      "assets/imagens/sobre8.png",
                      alignment: Alignment.centerRight,
                      width: 160,
                      height: 180,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16,left: 0,right: 5),
                    child: Text(
                      "Leve o bom humor \npara dentro da sua \ncasa, com miniaturas \nde memes com frases \npersonalizadas por você.",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Color(0xff929090),
                          fontSize: 11,
                          fontFamily: 'Montserrat'),
                    ),
                  ),
                ],
              ),

              Container(
                color: Colors.black,
                child: Column(
                  children: [
                    Image.asset(
                      "assets/imagens/linha.png",
                      alignment: Alignment.center,
                      width: 280,
                      height: 40,
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context,MaterialPageRoute(builder: (context) => Inicio()));
                      },
                      child: Image.asset(
                        "assets/imagens/sobre9.png",
                        alignment: Alignment.center,
                        width: 400,
                        height: 300,
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context,MaterialPageRoute(builder: (context) => Inicio()));
                      },
                      child: Image.asset(
                        "assets/imagens/sobre10.png",
                        alignment: Alignment.center,
                        width: 500,
                        height: 50,
                      ),
                    ),
                    SizedBox(height: 50,)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
