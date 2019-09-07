import 'package:sqflite/sqlite_api.dart';

import 'base_migration.dart';

class MigrationVersion1 implements BaseMigration {
  @override
  Future<void> migrate(Database db) async {
    await db.execute(
        'CREATE TABLE nfce ( id integer primary key autoincrement not null ,'
        'numero integer,serie integer,data_nfce text,valor_total float,'
        'valor_descontos float,forma_pagamento text,valor_pago float,'
        'consumidor_identificado integer,documento_consumidor text,'
        'comercio_id integer )');

    await db.execute('CREATE TABLE nfce_comercio ('
        'id integer primary key autoincrement not null ,'
        'razao_social text,cnpj text ,ie text ,endereco text )');

    await db.execute('CREATE TABLE nfce_item ('
        'id integer primary key autoincrement not null ,'
        'codigo varchar, descricao varchar,qtde float,'
        'un varchar, valor_unitario float,'
        'valor_total float, nfce_id integer )');

    await db.execute('CREATE TABLE qr_code ('
        'id integer primary key autoincrement not null ,'
        'qr_code text,'
        'sincronizado integer ,'
        'criado_em text, nfce_id integer )');

    await db.execute('CREATE INDEX "qr_code_nfce_id" on "qr_code"("nfce_id")');
    await db
        .execute('CREATE INDEX "nfce_item_nfce_id" on "nfce_item"("nfce_id")');
    await db
        .execute('CREATE INDEX "nfce_comercio_id" on "nfce"("comercio_id")');
  }
}
