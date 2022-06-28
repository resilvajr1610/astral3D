import 'package:flutter/material.dart';

class SlideDuvidas extends StatelessWidget {

  final String titulo,corpo;

  const SlideDuvidas({Key key, this.titulo, this.corpo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20,right: 10,bottom: 20,left: 10),
      child: Column(
        children: [
          Text(this.titulo,style: TextStyle(color: Colors.white,
              fontFamily: 'Montserrat',fontWeight: FontWeight.bold),),
          Container(height: 10),
          Text(this.corpo,textAlign: TextAlign.justify,style: TextStyle(color: Color(0xff929090),fontFamily: 'Montserrat'))
        ],
      ),
    );
  }
}
