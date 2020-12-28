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

  static Map<String, dynamic> toMap(Transaction transaction) {
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

  static Transaction toTransaction(Map<String, dynamic> map) {
    Transaction transaction = Transaction(
      map['value'],
      Contact(
        map['contact']['id'],
        map['contact']['name'],
        map['contact']['accountNumber'],
      ),
    );
    return transaction;
  }
}
