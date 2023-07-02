import 'package:seller/common/http/http.dart';
import 'package:seller/config/hosts.dart';
import 'package:seller/core/auth/model/token.dart';
import 'package:seller/core/auth/repo/token_data.dart';
import 'package:seller/modules/login/model/input/input_login.dart';
import 'package:seller/modules/login/model/service/service_login.dart';

class LoginRepo extends HttpService implements LoginService {
  @override
  Future<AuthToken> login(LoginInput input) async {
    try {
      final response = await post(
        '$host/login',
        body: input.toMap(),
      );
      return TokenData.fromMap(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
