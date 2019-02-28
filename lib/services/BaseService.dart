import 'package:flutter_minhas_nfce/data/SQLiteDb.dart';

abstract class BaseService {
  final SQLiteDb db = SQLiteDb();
}