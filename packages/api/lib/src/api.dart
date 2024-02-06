import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class Api{
  final _dio = Dio(); // With default `Options`.

  void configureDio() {
    // Set default configs
    _dio.options.baseUrl = 'https://api.pub.dev';

    _dio.options.connectTimeout = const Duration(seconds: 5);
    _dio.options.receiveTimeout = const Duration(seconds: 5);
    _dio.interceptors.add(PrettyDioLogger());
  }
  
  Dio get sendRequest => _dio;

}