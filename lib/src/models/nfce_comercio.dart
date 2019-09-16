class NFceComercio {
  int id;
  String razaoSocial;
  String cnpj;
  String ie;
  String endereco;

  NFceComercio.withRazaoSocial(this.razaoSocial, [this.cnpj]);
  NFceComercio.withCnpj(this.cnpj, [this.razaoSocial]);
  NFceComercio.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    razaoSocial = map['razao_social'];
    cnpj = map['cnpj'];
    ie = map['ie'];
    endereco = map['endereco'];
  }

  NFceComercio.fromMapSync(map) {
    razaoSocial = map['razao_social'];
    cnpj = map['cnpj'];
    ie = map['ie'];
    endereco = map['endereco'];
  }

  @override
  String toString() {
    return razaoSocial;
  }

  toMap() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['razao_social'] = razaoSocial;
    map['cnpj'] = cnpj;
    map['ie'] = ie;
    map['endereco'] = endereco;
    return map;
  }
}
