import 'package:seller/core/auth/model/token.dart';

abstract class StateAuth {}

class StateLogin extends StateAuth {
  AuthToken token;
  StateLogin({
    required this.token,
  });
}

class StateLogout extends StateAuth {}
