class QrCode {
  int id;
  String qrCode;
  DateTime criadoEm;
  bool sincronizado = false;
  int nfceId;

  QrCode(
      {this.id, this.qrCode, this.criadoEm, this.sincronizado, this.nfceId}) {
    if (criadoEm == null) criadoEm = DateTime.now();
    if (sincronizado == null) sincronizado = false;
  }

  QrCode.withId(this.id, this.qrCode, [this.criadoEm]);
  QrCode.withQrCode(this.qrCode, [this.criadoEm]) {
    if (this.criadoEm == null) criadoEm = DateTime.now();
  }

  factory QrCode.fromMap(Map<String, dynamic> map) => QrCode(
        id: map['id'],
        qrCode: map['qr_code'],
        criadoEm: DateTime.parse(map['criado_em']),
        sincronizado: map['sincronizado'] == 1 ? true : false,
        nfceId: map['nfce_id'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'qr_code': qrCode,
        "criado_em": criadoEm.toIso8601String(),
        'sincronizado': sincronizado ? 1 : 0,
        'nfce_id': nfceId,
      };
}
