import 'package:flutter_minhas_nfce/src/models/nfce_comercio.dart';
import 'package:inject/inject.dart';

import '../../models/nfce.dart';
import '../database_provider.dart';

class NfceRepository {
  final DatabaseProvider _databaseProvider;

  @provide
  NfceRepository(this._databaseProvider);

  Future<List<NFce>> list() async {
    var database = await this._databaseProvider.database;
    var list = await database.query('nfce');
    
    var nfces =  list.map((nfce) => NFce.fromMap(nfce)).toList();
    for(NFce nfce in nfces) {
      var comercio = await database.query('nfce_comercio', limit: 1, where: 'id = ?', whereArgs: [ nfce.comercioId]);
      nfce.comercio = NFceComercio.fromMap(comercio.first);
    }

    return nfces;
  }

  Future<NFce> insert(NFce nfce) async {
    var database = await this._databaseProvider.database;

    if (nfce.comercio != null) {
      nfce.comercio.id =
          await database.insert("nfce_comercio", nfce.comercio.toMap());
      nfce.comercioId = nfce.comercio.id;
    }

    var nfceMap = nfce.toMap();

    nfceMap.remove("itens");
    nfceMap.remove("comercio");

    var id = await database.insert("nfce", nfceMap);
    nfce.id = id;
    for (var item in nfce.itens) {
      item.nfceId = nfce.id;
      item.id = await database.insert("nfce_item", item.toMap());
    }

    return nfce;
  }
}
