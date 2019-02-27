class NFceComercio {
  int id;
  String razaoSocial;
  String cnpj;
  String ie;
  String endereco;

  NFceComercio() {

  }

  NFceComercio.withRazaoSocial(this.razaoSocial, [this.cnpj]);
  NFceComercio.withCnpj(this.cnpj, [this.razaoSocial]);

  @override
  String toString() {
    return razaoSocial;
  }
}