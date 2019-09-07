import '../../models/nfce.dart';
import '../database_provider.dart';

class NfceRepository {
  final DatabaseProvider _databaseProvider;

  NfceRepository(this._databaseProvider);

  Future<List<NFce>> list() async {
    var database = await this._databaseProvider.database;
    var list  = await database.query('nfce');
    return list.map((nfce) => NFce.fromMap(nfce)).toList();
  }

}