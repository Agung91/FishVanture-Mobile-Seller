import 'package:seller/core/auth/model/token.dart';
import 'package:seller/modules/login/model/input/input_login.dart';

abstract class LoginService {
  Future<AuthToken> login(LoginInput input);
}
