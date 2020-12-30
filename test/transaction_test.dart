import 'package:flutter_bytebank02/models/transaction.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Should return transaction value when creating a transaction", () {
    final Transaction transaction = Transaction(null, 200, null);
    expect(transaction.value, 200);
  });
  test("Should throw Error when creating a transaction with negative value",
      () {
    expect(() => Transaction(null, 0, null), throwsAssertionError);
  });
}
