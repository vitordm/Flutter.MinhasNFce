class QrCode {
  int id;
  String qrCode;
  DateTime criadoEm;
  bool sincronizado = false;
  int nfceId;

  QrCode() {
    criadoEm = DateTime.now();
  }
  QrCode.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    qrCode = map['qr_code'];
    criadoEm = DateTime.parse(map['criado_em']);
    sincronizado = map['sincronizado'];
    nfceId = map['nfce_id'];
  }

  QrCode.withId(this.id, this.qrCode, [this.criadoEm]);
  QrCode.withQrCode(this.qrCode, [this.criadoEm]) {
    if (this.criadoEm == null) criadoEm = DateTime.now();
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['qr_code'] = qrCode;
    map['criado_em'] = criadoEm.toIso8601String();
    map['sincronizado'] = sincronizado;
    map['nfce_id'] = nfceId;
    return map;
  }


}
