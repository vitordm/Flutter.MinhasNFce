import 'package:flutter_minhas_nfce/models/nfce_comercio.dart';

class NFce {
  int id;
  int numero ;
  int serie ;
  DateTime dataNfce;
  double valorTotal;
  double vaalorDescontos ;
  String formaPagamento ;
  double valorPago ;
  bool consumidorIdentificado ;
  String documentoConsumidor ;
  int comercioId;
  
  String get numeroSerie => "$numero-$serie";

  NFceComercio nFceComercio;

  NFce(this.id, this.numero, this.serie);

  NFce resolveSomething(NFceComercio nfceComercio){
    this.nFceComercio = nfceComercio;
    return this;
  } 
}