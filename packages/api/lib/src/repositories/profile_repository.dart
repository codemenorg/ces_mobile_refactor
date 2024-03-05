import 'package:api/src/api.dart';
import 'package:api/src/models/profile.dart';
import 'package:dio/dio.dart';

class ProfileRepository {
  ProfileRepository({
    required this.flavor,
  }) {
    _api = Api(flavor: flavor);
  }

  final Flavor flavor;
  late Api _api;

  Future<Profile> get() async {
    try {
      Response response = await _api.sendRequest
          .get("http://usermgm-v2.ces.codemen.org/usermgm/v1/profile/get/id");
      return profileFromJson(response.toString());
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }
}
