import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'migrations/base_migration.dart';
import 'migrations/migration_version_1.dart';
import 'dart:async';
import 'dart:io';

const DATABASE_VERSION = 1;

class DatabaseProvider {
  //static DatabaseProvider _instance;
  static Database _database;

  final List<int> _databaseVersions = [1];
  Map<int, BaseMigration> _databaseMigrations = Map<int, BaseMigration>();

  DatabaseProvider(){
    _databaseMigrations[1] = MigrationVersion1();
  }

  /*
  DatabaseProvider._createInstance(){
    _databaseMigrations[1] = MigrationVersion1();
  }

  factory DatabaseProvider() {
    if (_instance == null) {
      _instance = DatabaseProvider._createInstance();
    }
    return _instance;
  }*/

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'minhasnfce.db';

    // Open/create the database at a given path
    var database = await openDatabase(path,
        version: DATABASE_VERSION,
        onConfigure: _onConfigureDb,
        onCreate: _onCreateDb,
        onUpgrade: _onUpgradeDb,
        onDowngrade: _onDowngradeDb,
        onOpen: _onOpenDb,
        readOnly: false,
        singleInstance: true);
    return database;
  }

  void _onCreateDb(Database db, int newVersion) {
    for(var version in _databaseVersions){
      BaseMigration m = _databaseMigrations[version];
      m.migrate(db);
    }
  }

  void _onUpgradeDb(Database db, int oldVersion, int newVersion) {}

  void _onOpenDb(Database db) {}

  void _onConfigureDb(Database db) {}

  void _onDowngradeDb(Database db, int oldVersion, int newVersion) {}
}
