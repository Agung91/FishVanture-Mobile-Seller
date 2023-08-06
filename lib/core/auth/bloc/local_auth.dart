import 'package:seller/core/auth/bloc/authenticated.dart';
import 'package:seller/core/auth/bloc/bloc_auth.dart';
import 'package:seller/core/auth/bloc/event.dart';
import 'package:flutter/foundation.dart';

import '../repo/local_storage.dart';

class LocalAuth extends Authenticated {
  LocalAuth() {
    _tryLogin();
  }
  _tryLogin() async {
    try {
      if (kDebugMode) {
        print(
            '===========================LocalAuth===================================');
      }
      final token = await LocalStorage().getToken();
      AuthBloc().raise(EventAuthLogin(token));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Future<void> onLogin() async {
    final token = AuthBloc().getToken();
    if (token != null) {
      LocalStorage().saveToken(token);
    }
  }

  @override
  Future<void> onLogout() async {
    LocalStorage().removeToken();
  }
}
