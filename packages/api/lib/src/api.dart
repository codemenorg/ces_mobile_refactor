import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

enum Flavor{
  production,
  staging,
  developmenmt,
}

class Api{
  // development url
  late Uri baseUrl;

  Api({required Flavor flavor}) {
    if(flavor == Flavor.production) {
      baseUrl = Uri.parse('https://api.pub.dev');
    } else if(flavor == Flavor.staging) {
      baseUrl = Uri.parse('https://api.pub.dev');
    } else {
      baseUrl = Uri.parse('https://api.pub.dev');
    }
  }
  final _dio = Dio();

  void configureDio() {
    _dio.options.baseUrl = baseUrl.toString();
    _dio.options.connectTimeout = const Duration(seconds: 5);
    _dio.options.receiveTimeout = const Duration(seconds: 5);
    _dio.interceptors.add(PrettyDioLogger());
  }
  
  Dio get sendRequest => _dio;

}