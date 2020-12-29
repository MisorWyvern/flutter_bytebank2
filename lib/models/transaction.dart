import 'contact.dart';

class Transaction {
  final double value;
  final Contact contact;

  Transaction(
    this.value,
    this.contact,
  );

  @override
  String toString() {
    return 'Transaction{value: $value, contact: $contact}';
  }

  static Map<String, dynamic> toJson(Transaction transaction) {
    final Map<String, dynamic> transactionMap = {
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
      map['value'],
      Contact.fromJson(map['contact']),
    );
    return transaction;
  }
}
