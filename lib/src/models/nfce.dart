import 'nfce_comercio.dart';
import 'nfce_item.dart';

class NFce {
  int id;
  String numero;
  String serie;
  DateTime dataNfce;
  String chaveAcesso;
  String protocoloAutorizacao;
  bool consumidorIdentificado;
  String documentoConsumidor;
  double valorTotal;
  double valorDesconto;
  String formaPagamento;
  double valorPago;
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
    chaveAcesso = map['chave_acesso'];
    protocoloAutorizacao = map['protocolo_autorizacao'];
    consumidorIdentificado = map['consumidor_identificado'] == 1 ? true : false;
    documentoConsumidor = map['documento_consumidor'];
    valorTotal = map['valor_total'];
    valorDesconto = map['valor_desconto'];
    formaPagamento = map['forma_pagamento'];
    valorPago = map['valor_pago'];
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

  NFce.fromMapSync(Map<String, dynamic> map) {
    numero = map['numero'];
    serie = map['serie'];
    dataNfce = map['dataNfce'];
    chaveAcesso = map['chaveAcesso'];
    protocoloAutorizacao = map['protocoloAutorizacao'];
    consumidorIdentificado = map['consumidorIdentificado'];
    documentoConsumidor = map['documentoConsumidor'];
    valorTotal = map['valorTotal'];
    valorDesconto = map['valorDesconto'];
    formaPagamento = map['formaPagamento'];
    valorPago = map['valorPago'];
    comercio = NFceComercio.fromMapSync(map['comercio']);

    var itensValues = map['itens'];
    List<Map<String, dynamic>> itensList;

    if (itensValues is List) {
      itensList = itensValues;
    } else {
      itensList = itensValues.toList();
    }
    
    if (itensList != null && itensList.length > 0) {
      this.itens.addAll(itensList.map((item) => NFceItem.fromMapSync(item)));
    }
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['numero'] = numero;
    map['serie'] = serie;
    map['data_nfce'] = dataNfce?.toIso8601String();
    map['chave_acesso'] = chaveAcesso;
    map['protocolo_autorizacao'] = protocoloAutorizacao;
    map['consumidor_identificado'] = consumidorIdentificado ? 1 : 0;
    map['documento_consumidor'] = documentoConsumidor;
    map['valor_total'] = valorTotal;
    map['valor_desconto'] = valorDesconto;
    map['forma_pagamento'] = formaPagamento;
    map['valor_pago'] = valorPago;
    map['comercio_id'] = comercioId;

    if (comercio != null) {
      map['comercio'] = comercio.toMap();
    }

    if (itens.length > 0) {
      var itensMap = List<Map<String, dynamic>>();
      for(var item in itens) {
        itensMap.add(item.toMap());
      }
      
      map['itens'] = itensMap.toList();
    }

    return map;
  }
}
