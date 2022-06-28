import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SlideAction extends StatelessWidget {

  final String image;

  const SlideAction({Key key, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.only(top: 20,right: 10,bottom: 20,left: 10),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(this.image),
            fit: BoxFit.fitHeight),
      ),
    );
  }
}
