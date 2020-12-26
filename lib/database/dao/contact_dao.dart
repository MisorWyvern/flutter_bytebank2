import 'dart:async';

import 'package:flutter_bytebank02/models/contact.dart';
import 'package:sqflite/sqflite.dart';

import '../app_database.dart';

class ContactDAO {
  static const String _tableName = 'tb_contacts';
  static const String _id = "id";
  static const String _name = "name";
  static const String _accountNumber = "account_number";
  static const String createTableSQL = """
        CREATE TABLE $_tableName(
          $_id  INTEGER PRIMARY KEY,
          $_name  TEXT,
          $_accountNumber  INTEGER
        );
      """;

  Future<int> save(Contact contact) async {
    final Database db = await createDatabase();
    Map<String, dynamic> contactMap = _toMap(contact);
    return db.insert(_tableName, contactMap);
  }

  Future<List<Contact>> findAll() async {
    final Database db = await createDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);

    List<Contact> contacts = _toList(result);
    return contacts;
  }

  Future<int> update(Contact contact) async {
    final Database db = await createDatabase();
    final Map<String, dynamic> contactMap = _toMap(contact);
    return db.update(
      _tableName,
      contactMap,
      where: '$_id = ?',
      whereArgs: [contact.id],
    );
  }

  Future<int> delete(int id) async {
    final Database db = await createDatabase();
    return db.delete(
      _tableName,
      where: '$_id = ?',
      whereArgs: [id],
    );
  }

  List<Contact> _toList(List<Map<String, dynamic>> result) {
    final List<Contact> contacts = List();
    result.forEach((row) {
      final Contact contact = Contact(
        row[_id],
        row[_name],
        row[_accountNumber],
      );
      contacts.add(contact);
    });
    return contacts;
  }

  Map<String, dynamic> _toMap(Contact contact) {
    final Map<String, dynamic> contactMap = {};
    contactMap[_name] = contact.name;
    contactMap[_accountNumber] = contact.accountNumber;
    return contactMap;
  }
}
