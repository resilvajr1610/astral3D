import 'package:flutter/material.dart';

class Cor{

  static List<DropdownMenuItem<String>> getCores(){
    List<DropdownMenuItem<String>> itensDropCores = [];

    //categorias
    itensDropCores.add(
        DropdownMenuItem(child: Text(
          "Selecionar cor",style: TextStyle(
            color: Color(0xfff9a72b)
        ),
        ),value: null,)
    );
    itensDropCores.add(
        DropdownMenuItem(child: Text("Branco"),value: "branco",)
    );
    itensDropCores.add(
        DropdownMenuItem(child: Text("Preto"),value: "preto",)
    );
    itensDropCores.add(
        DropdownMenuItem(child: Text("Colorido"),value: "pintado",)
    );
    return itensDropCores;
  }
}