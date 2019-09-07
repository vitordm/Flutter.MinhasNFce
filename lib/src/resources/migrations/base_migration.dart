
import 'package:sqflite/sqflite.dart';

abstract class BaseMigration {
  void migrate(Database db);
}