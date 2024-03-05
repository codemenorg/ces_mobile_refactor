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
          '29d50327db04eae60c7692b9ff68cb12391e8401ad5a1d705b837abdc7b6f5476db2c5e555305221dcda6d830166a54b4fccb227a929e868575c6ac37ca5793ef10046ad36e70a6ebdf36b9e5972ff100eec2ea790f4c24dd39e1a90648e267a378bb7f6cd78adc53ce2506840fe86ccc729c700d66f3b696e265791ddfc2d39c3b272f597d320804ca5904a1d8e80ed15853f0bc517bd230f75fbde8119ec7cf52415834b5cf9c31e21e07365d038f04fc20c6b7184001e417b34b52cb676ecc2b276f92752d117b0dbab1049d407e606c2bae47ee52855f1c60a13b1af9e0c147cb49acbe867bcd4e598c6622490483d448b3f0c09bddcefd4a459e31d9deeeb09ceed3a4f32f01dd6276a177f079c27c32bb4'
    };
    _dio.interceptors.add(PrettyDioLogger());
  }
  final _dio = Dio();

  Dio get sendRequest => _dio;
}
