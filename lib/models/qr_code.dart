class QrCode {
  int id;
  String qrCode;
  DateTime criadoEm;

  QrCode() {
    criadoEm = DateTime.now();
  }

  QrCode.withId(this.id, this.qrCode, [this.criadoEm]);
  QrCode.withQrCode(this.qrCode, [this.criadoEm]){
    if (this.criadoEm == null)
      criadoEm = DateTime.now();
  }

}