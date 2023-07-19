import 'package:seller/common/http/http.dart';
import 'package:seller/config/hosts.dart';
import 'package:seller/modules/pond/model/model_pond.dart';
import 'package:seller/modules/pond/model/service_pond.dart';

class PondHttpRepo extends HttpService implements PondService {
  @override
  Future<PondModel?> getPond() async {
    try {
      final response = await get('$host/pond');
      if (response is Map<String, dynamic>) {
        return PondModel.fromMap(response);
      }
      throw 'Can\'t Parse Pond Model';
    } catch (e) {
      rethrow;
    }
  }
}
