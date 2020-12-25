import 'dart:async';

import 'package:flutter_bytebank02/models/contact.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> createDatabase() {
  return getDatabasesPath().then((dbPath) {
    final String path = join(dbPath, "bytebank.db");
    return openDatabase(path, onCreate: (db, version) {
      db.execute("""
        CREATE TABLE tb_contacts(
          id  INTEGER PRIMARY KEY,
          name  TEXT,
          account_number  INTEGER
        );
      """);
    }, version: 1);
  });
}

Future<int> save(Contact contact) {
  return createDatabase().then((db) {
    final Map<String, dynamic> contactMap = {};
    contactMap['name'] = contact.name;
    contactMap['account_number'] = contact.accountNumber;
    return db.insert("tb_contacts", contactMap);
  });
}

Future<List<Contact>> findAll() {
  return createDatabase().then((db) {
    return db.query("tb_contacts").then((maps) {
      final List<Contact> contacts = List();
      maps.forEach((map) {
        final Contact contact = Contact(
          map['id'],
          map['name'],
          map['account_number'],
        );
        contacts.add(contact);
      });
      return contacts;
    });
  });
}
