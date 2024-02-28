import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

enum Flavor {
  production,
  staging,
  development,
}

class Api {
  // development url
  late Uri baseUrl;

  Api({required Flavor flavor}) {
    if (flavor == Flavor.production) {
      baseUrl = Uri.parse('http://api-v2.ces.codemen.org/api/v1');
    } else if (flavor == Flavor.staging) {
      baseUrl = Uri.parse('http://api-v2.ces..org/api/v1');
    } else {
      baseUrl = Uri.parse('http://api-v2.ces.codemen.org/api/v1');
    }

    _dio.options.baseUrl = baseUrl.toString();
    _dio.options.connectTimeout = const Duration(seconds: 5);
    _dio.options.receiveTimeout = const Duration(seconds: 5);
    _dio.options.headers = {
      'authorization':
          'f2cd87ca8f51aa5c64a125186cc439277feb00f551bca234e73e51f128656b38e2f1a85be048f12f8beccf0c282b6b679b52ded42c14d369f73d7832dac9971583ecaaffea9e868a52964595a2147097768be548efc57c9ec8300038072bf566e25d15162f4067f5d21c2b5b21c976bb3ce072d59fc6bfa20dfc27e7df9bd010aa4cae795ffcbf404fac31432b7d0c356955f6ed218c11e5c09c480c4ff089c980bc825d7784f1e06c2dd96bf24be270b4399f9fe607a540e7bb7f52d1e7fe6301d24a29c2b6d7834a37bedae90685f0d3c7d4a7eecca6bd16e604fa4c308843d4964bc0b9318cf23cb33328c1db2ba26227e5d31cdfa826a1a1a1d347f9c5557f173cfc4fd0d09b72679245f900e971adb7cb36'
    };
    _dio.interceptors.add(PrettyDioLogger());
  }
  final _dio = Dio();

  Dio get sendRequest => _dio;
}
