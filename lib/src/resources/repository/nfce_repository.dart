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
    return list.map((nfce) => NFce.fromMap(nfce)).toList();
  }

  Future<NFce> insert(NFce nfce) async {
    var database = await this._databaseProvider.database;

    if (nfce.comercio != null) {
      nfce.comercio.id =
          await database.insert("nfce_comercio", nfce.comercio.toMap());
      nfce.comercioId = nfce.comercio.id;
    }

    var id = await database.insert("nfce", nfce.toMap());
    nfce.id = id;
    for (var item in nfce.itens) {
      item.nfceId = nfce.id;
      item.id = await database.insert("nfce_item", item.toMap());
    }

    return nfce;
  }
}
