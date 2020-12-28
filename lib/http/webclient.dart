import 'package:http/http.dart';

void findAll() async {
  final Response response = await get('http://192.168.56.1:8080/transactions');
  print(response.body);
}
