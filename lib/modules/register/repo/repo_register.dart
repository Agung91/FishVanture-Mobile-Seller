import 'package:seller/common/http/http.dart';
import 'package:seller/config/hosts.dart';
import 'package:seller/modules/register/model/input/input_register.dart';
import 'package:seller/modules/register/model/service/service_register.dart';

class RegisterRepo extends HttpService implements RegsiterService {
  @override
  Future<String?> register(RegsiterInput input) async {
    try {
      final response = await post(
        '$host/register',
        body: input.toMap(),
      );
      return response.id;
    } catch (e) {
      rethrow;
    }
  }
}
