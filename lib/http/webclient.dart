import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

void findAll() async {
  final Client client =
      HttpClientWithInterceptor.build(interceptors: [LoggingInterceptor()]);
  final Response response = await client.get('http://192.168.1.106:8080/transactions');
}

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    print("Request");
    print("url: ${data.baseUrl}");
    print("headers: ${data.headers}");
    print("body: ${data.body}");
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    print("Response");
    print("status code: ${data.statusCode}");
    print("headers: ${data.headers}");
    print("body: ${data.body}");
    return data;
  }
}
