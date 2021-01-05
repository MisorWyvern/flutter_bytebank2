import 'package:flutter_bytebank02/database/dao/contact_dao.dart';
import 'package:flutter_bytebank02/http/webclients/transaction_webclient.dart';
import 'package:mockito/mockito.dart';

class MockContactDAO extends Mock implements ContactDAO {}

class MockTransactionWebClient extends Mock implements TransactionWebClient {}
