class NFceItem {
  int id;
  String codigo;
  String descricao;
  double qtde;
  String un;
  double valorUnitario;
  double valorTotal;
  int nfceId;

  NFceItem.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    codigo = map['codigo'];
    descricao = map['descricao'];
    qtde = map['qtde'];
    un = map['un'];
    valorUnitario = map['valor_unitario'];
    valorTotal = map['valor_total'];
    nfceId = map['nfce_id'];
  }

  NFceItem.fromMapSync(Map<String, dynamic> map) {
    codigo = map['codigo'];
    descricao = map['descricao'];
    qtde = map['qtde'];
    un = map['un'];
    valorUnitario = map['valorUnitario'];
    valorTotal = map['valorTotal'];
  }

  toMap() {
    var map = new Map<String, dynamic>();
    map['id'] = id;
    map['codigo'] = codigo;
    map['descricao'] = descricao;
    map['qtde'] = qtde;
    map['un'] = un;
    map['valor_unitario'] = valorUnitario;
    map['valor_total'] = valorTotal;
    map['nfce_id'] = nfceId;
    return map;
  }
}
