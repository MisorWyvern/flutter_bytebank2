import 'contact.dart';

class Transaction {
  final String id;
  final double value;
  final Contact contact;

  Transaction(
    this.id,
    this.value,
    this.contact,
  );

  @override
  String toString() {
    return 'Transaction{id: $id, value: $value, contact: $contact}';
  }

  static Map<String, dynamic> toJson(Transaction transaction) {
    final Map<String, dynamic> transactionMap = {
      "id": transaction.id,
      "value": transaction.value,
      "contact": {
        "id": transaction.contact.id,
        "name": transaction.contact.name,
        "accountNumber": transaction.contact.accountNumber,
      }
    };
    return transactionMap;
  }

  static Transaction fromJson(Map<String, dynamic> map) {
    Transaction transaction = Transaction(
      map['id'],
      map['value'],
      Contact.fromJson(map['contact']),
    );
    return transaction;
  }
}
