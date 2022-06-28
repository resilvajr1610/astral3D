import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SlideTile extends StatelessWidget {

  final String image;
  final bool activePage;
  final String titulo;
  final VoidCallback onTap;

  const SlideTile({Key key, this.image, this.activePage, this.titulo, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final double top = this.activePage ? 10 : 50;
    final double bottom = this.activePage ? 10 : 50;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 50),
            child: Text(
                this.titulo,
                style: TextStyle(color: Colors.white,fontFamily: 'Mokoto',fontSize: 20))),
          Flexible(
            child: AnimatedContainer(
              curve: Curves.ease,
              duration: Duration(milliseconds: 150),
              margin: EdgeInsets.only(top: top,right: 10,bottom: bottom,left: 10),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(this.image),
                    fit: BoxFit.fill),
                /*boxShadow: [
                      BoxShadow(
                        color: Colors.black87,
                        blurRadius: 30,
                        offset: Offset(20,20)
                      )
                    ]*/
              ),
            ),
          ),
        ],
      ),
    );
  }
}
