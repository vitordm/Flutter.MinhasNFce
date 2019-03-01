import 'dart:async';

import 'package:flutter_minhas_nfce/models/qr_code.dart';
import 'package:flutter_minhas_nfce/services/BaseService.dart';

class QrCodeService extends BaseService {
  
  Future<QrCode> insert(QrCode qrCode) async {
    var database = await this.db.database;
    var id = await database.insert('qr_code', qrCode.toMap());
    qrCode.id = id;
    return qrCode;
  }

  Future<List<QrCode>> list() async {
    var database = await this.db.database;
    var list  = await database.query('qr_code');
    return list.isNotEmpty ? list.map((qrcode) => QrCode.fromMap(qrcode)).toList() : [];
  }

}