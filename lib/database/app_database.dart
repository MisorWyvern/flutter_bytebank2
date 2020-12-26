import 'dart:async';

import 'package:flutter_bytebank02/database/dao/contact_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> createDatabase() async {
  final String path = join(await getDatabasesPath(), 'bytebank.db');
  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(ContactDAO.createTableSQL);
    },
    version: 1,
    //     onDowngrade: onDatabaseDowngradeDelete,
  );
}

// Future<Database> createDatabase() {
//   return getDatabasesPath().then((dbPath) {
//     final String path = join(dbPath, "bytebank.db");
//     return openDatabase(
//       path,
//       onCreate: (db, version) {
//         db.execute("""
//         CREATE TABLE tb_contacts(
//           id  INTEGER PRIMARY KEY,
//           name  TEXT,
//           account_number  INTEGER
//         );
//       """);
//       },
//       version: 1,
//       //     onDowngrade: onDatabaseDowngradeDelete,
//     );
//   });
// }
