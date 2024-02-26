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
          '6ad733919d41ac0b69695f519ce53d4c8640421dfcb395d465ced857fedad03cd6b8abea6576a0aeb4e283931d026b96d99e38475982545c1184caef1de155d445fdf68799f154afa22b30e088c2a2b1262745946003b98917db1d69e60b801d56f929bb03a15f7bf4a1e8828fd6e3b546e835e65c533639cfb70c0ea0aa96ce1dcce75879b2b160ae29f361b68034643e29367b1219ffb8482ba72132494267f7e9127e98c5c7331dd4ea9840f30712ac0a761add6276494d1d608785a66905a8a28c0df9e723503b5e17ff57fd1b1da4f66ece994a0bcbd998720d17220670ade711bf7d1f79f4d9216087076727208d341fc8da5d414e235d7eed4a913021356f2f72fa814417fd6786cc7a1fb8fd3837e5cd'
    };
    _dio.interceptors.add(PrettyDioLogger());
  }
  final _dio = Dio();

  Dio get sendRequest => _dio;
}
