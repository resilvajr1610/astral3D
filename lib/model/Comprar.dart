import 'package:cloud_firestore/cloud_firestore.dart';

class Comprar {

  String _idUsuario;
  String _idCompra;
  String _produto;
  String _cor;
  String _preco;
  String _nome;
  String _cep;
  String _cidade;
  String _estado;
  String _bairro;
  String _numero;
  String _telefone;
  String _ap;
  String _frete;
  String _foto;
  String _rua;
  double _precoPago;
  String _status;
  String _tokenCliente;
  String _data;

  Comprar();

  Comprar.gerarId(){
    Firestore db = Firestore.instance;
    CollectionReference perguntas = db.collection("comprar");
    this.idCompra = perguntas.document().documentID;
  }

  Map<String,dynamic> toMap(){
    Map<String,dynamic> map = {
      "idUsuario" : this.idUsuario,
      "produto" : this.produto,
      "cor" : this.cor,
      "preco" : this.preco
    };
    return map;
  }

  Map<String,dynamic> toCompra(){
    Map<String,dynamic> map = {
      "nome" : this.nome,
      "cep" : this.cep,
      "rua" : this.rua,
      "cidade" : this.cidade,
      "estado" : this.estado,
      "bairro" : this.bairro,
      "numero" : this.numero,
      "telefone" : this.telefone,
      "ap" : this.ap,
      "frete" : this.frete,
      "precoPago" : this.precoPago,
      "status" : this.status,
      "tokenCliente" : this.tokenCliente,
      "data" : this.data,
    };
    return map;
  }
  Comprar.fromDocumentSnapshot(DocumentSnapshot documentSnapshot){
    this.idCompra = documentSnapshot.documentID;
    this.produto = documentSnapshot["produto"];
    this.cor = documentSnapshot["cor"];
    this.precoPago = documentSnapshot["precoPago"];
    this.nome = documentSnapshot["nome"];
    this.cep = documentSnapshot["cep"];
    this.cidade = documentSnapshot["cidade"];
    this.estado = documentSnapshot["estado"];
    this.bairro = documentSnapshot["bairro"];
    this.numero = documentSnapshot["numero"];
    this.telefone = documentSnapshot["telefone"];
    this.ap = documentSnapshot["ap"];
    this.frete = documentSnapshot["frete"];
    this.foto = documentSnapshot["foto"];
    this.rua = documentSnapshot["rua"];
    this.status = documentSnapshot["status"];
    this.tokenCliente = documentSnapshot["tokenCliente"];
    this.data = documentSnapshot["data"];
  }

  String get data => _data;

  set data(String value) {
    _data = value;
  }

  String get tokenCliente => _tokenCliente;

  set tokenCliente(String value) {
    _tokenCliente = value;
  }

  String get status => _status;

  set status(String value) {
    _status = value;
  }

  String get idCompra => _idCompra;

  set idCompra(String value) {
    _idCompra = value;
  }

  String get rua => _rua;

  set rua(String value) {
    _rua = value;
  }

  double get precoPago => _precoPago;

  set precoPago(double value) {
    _precoPago = value;
  }

  String get frete => _frete;

  set frete(String value) {
    _frete = value;
  }

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }

  String get preco => _preco;

  set preco(String value) {
    _preco = value;
  }

  String get cor => _cor;

  set cor(String value) {
    _cor = value;
  }

  String get produto => _produto;

  set produto(String value) {
    _produto = value;
  }

  String get idUsuario => _idUsuario;

  set idUsuario(String value) {
    _idUsuario = value;
  }

  String get cep => _cep;

  String get ap => _ap;

  set ap(String value) {
    _ap = value;
  }

  String get telefone => _telefone;

  set telefone(String value) {
    _telefone = value;
  }

  String get numero => _numero;

  set numero(String value) {
    _numero = value;
  }

  String get bairro => _bairro;

  set bairro(String value) {
    _bairro = value;
  }

  String get estado => _estado;

  set estado(String value) {
    _estado = value;
  }

  String get cidade => _cidade;

  set cidade(String value) {
    _cidade = value;
  }

  set cep(String value) {
    _cep = value;
  }

  String get foto => _foto;

  set foto(String value) {
    _foto = value;
  }
}

