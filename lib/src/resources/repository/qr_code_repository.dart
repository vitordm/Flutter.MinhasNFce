import 'package:flutter_minhas_nfce/src/models/qr_code.dart';
import 'package:inject/inject.dart';

import '../database_provider.dart';

class QrCodeRepository {
  final DatabaseProvider _databaseProvider;

  @provide
  QrCodeRepository(this._databaseProvider);

  Future<QrCode> insert(QrCode qrCode) async {
    var db = await this._databaseProvider.database;
    var id = await db.insert("qr_code", qrCode.toMap());
    qrCode.id = id;
    return qrCode;
  }

  Future<QrCode> atualizar(QrCode qrCode) {
    throw Exception("Method not implemented!");
  }
}