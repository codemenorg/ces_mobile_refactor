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
          'e7bc539e50bebe903512793da5df556a6d393f9414e007ae19f625086e3eb517f913f7d708fd05ce5ed9a3d8f41626be463aeb127a45ba6a762890029e15c9bcab2dbb3dbf6148b75c6ee295ad98e4d96a3fb932833590cdf50c4aa0a9a6a6e08a5d603fe131f7000cf637c930e36616b845b70210e427610c04aca6f3ff61f970359641e0233bc3766f46dd84d8a852e58a5fddceb5508fd521e20c538d2c2183e52ab6c2f4bcd3e8055950f1bcc448b91185562eff68b9017083e235a289cd597ecc65443aaf343789bd50d5e3c2698afdf9ccf82805cb53913ab4e86c0cbc84c148bda6647d484c410038b5db73922a6557adacbf050365df86396c65484d8cd947f41e0f8ccb62bdc8d60d0085ac0bdf22b8'
    };
    _dio.interceptors.add(PrettyDioLogger());
  }
  final _dio = Dio();

  Dio get sendRequest => _dio;
}
