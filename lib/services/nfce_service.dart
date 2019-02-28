import 'dart:async';

import 'package:flutter_minhas_nfce/models/nfce.dart';
import 'package:flutter_minhas_nfce/services/BaseService.dart';

class NFceService extends BaseService {
  Future<List<NFce>> list() async {
    var database = await this.db.database;
    var list  = await database.query('nfce');
    return list.map((nfce) => NFce.fromMap(nfce));
  }
}