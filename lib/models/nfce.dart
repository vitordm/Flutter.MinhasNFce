import 'package:flutter_minhas_nfce/models/nfce_comercio.dart';
import 'package:flutter_minhas_nfce/models/nfce_item.dart';

class NFce {
  int id;
  int numero;
  int serie;
  DateTime dataNfce;
  double valorTotal;
  double valorDescontos;
  String formaPagamento;
  double valorPago;
  bool consumidorIdentificado;
  String documentoConsumidor;
  int comercioId;

  String get numeroSerie => "$numero-$serie";

  NFceComercio comercio;

  final itens = List<NFceItem>();

  NFce(this.id, this.numero, this.serie);

  NFce.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    numero = map['numero'];
    serie = map['serie'];
    dataNfce = DateTime.parse(map['data_nfce']);
    valorTotal = map['valor_total'];
    valorDescontos = map['valor_descontos'];
    formaPagamento = map['forma_pagamento'];
    valorPago = map['valor_pago'];
    consumidorIdentificado = map['consumidor_identificado'];
    documentoConsumidor = map['documento_consumidor'];
    comercioId = map['comercio_id'];

    var comercioMap = map['comercio'];
    if (comercio != null) {
      comercio = NFceComercio.fromMap(comercioMap);
    }

    var itensList = map['itens'] as List<Map<String, dynamic>>;
    if (itensList != null && itensList.length > 0) {
      this.itens.addAll(itensList.map((item) => NFceItem.fromMap(item)));
    }
  }

  NFce resolveSomething(NFceComercio nfceComercio) {
    this.comercio = nfceComercio;
    return this;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['numero'] = numero;
    map['serie'] = serie;
    map['data_nfce'] = dataNfce?.toIso8601String();
    map['valor_total'] = valorTotal;
    map['valor_descontos'] = valorDescontos;
    map['forma_pagamento'] = formaPagamento;
    map['valor_pago'] = valorPago;
    map['consumidor_identificado'] = consumidorIdentificado;
    map['documento_consumidor'] = documentoConsumidor;
    map['comercio_id'] = comercioId;

    if (comercio != null) {
      map['comercio'] = comercio.toMap();
    }

    if (itens.length > 0) {
      List<Map<String, dynamic>> itensMap = itens.map((item) => item.toMap());
      map['itens'] = itensMap;
    }

    return map;
  }
}
