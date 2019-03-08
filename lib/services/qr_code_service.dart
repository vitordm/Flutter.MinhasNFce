import 'dart:async';

import 'package:flutter_minhas_nfce/models/nfce.dart';
import 'package:flutter_minhas_nfce/models/qr_code.dart';
import 'package:flutter_minhas_nfce/services/base_service.dart';
import 'package:flutter_minhas_nfce/services/nfce_service.dart';
import 'package:vitor_myparser_nfce/my_parser_nfce.dart';;

class QrCodeService extends BaseService {

  final nfceService = NFceService();
  
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

  Future<NFce> syncQrCode(QrCode qrCode) async {
    try {
      var myParserNFceFactory = MyParserNFceFactory(qrCode.qrCode);
      var downloadNfce = await myParserNFceFactory.make();
      if (downloadNfce !=null) {
        //todo: Inserir NFce
      }
    } catch(e) {
      print(e);
    }
    return null;
  }

}