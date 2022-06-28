import 'package:astrall/model/Comprar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../main.dart';

class ItemPedidos extends StatelessWidget {

  Comprar comprar;
  VoidCallback onTapItem;

  ItemPedidos(
      {
        @required this.comprar,
        this.onTapItem
      });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onTapItem,
      child: Card(
        color: Color(0xff545454),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Row(children:<Widget> [
            Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.all(4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Produto : ".toUpperCase() +comprar.produto.toUpperCase(),
                        style:TextStyle(color: Colors.white,
                            fontSize: 12,fontWeight: FontWeight.bold,fontFamily: 'Montserrat'),
                      ),
                    ],
                  ),
                )
            ),
          ],
          ),
        ),
      ),
    );
  }
}
