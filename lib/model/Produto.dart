import 'package:cloud_firestore/cloud_firestore.dart';

class Produto{

  String _id = "";
  String _nomeProduto = "";
  String _de = "";
  String _por = "";
  String _branco = "";
  String _preto = "";
  String _pintado = "";

  Produto();

  Map<String,dynamic> toMap(){
    Map<String,dynamic> map = {
      "idProduto" : this.id,
      "nomeProduto" : this.nomeProduto,
      "de" : this.de,
      "por" : this.por,
      "branco" : this.branco,
      "preto" : this.preto,
      "pintado" : this.pintado,
    };
    return map;
  }
  String get nomeProduto => _nomeProduto;

  set nomeProduto(String value) {
    _nomeProduto = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get de => _de;

  set de(String value) {
    _de = value;
  }

  String get por => _por;

  set por(String value) {
    _por = value;
  }

  String get branco => _branco;

  set branco(String value) {
    _branco = value;
  }

  String get preto => _preto;

  set preto(String value) {
    _preto = value;
  }

  String get pintado => _pintado;

  set pintado(String value) {
    _pintado = value;
  }
}