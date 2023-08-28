import 'package:seller/common/errors/errors.dart';
import 'package:seller/core/auth/bloc/bloc_auth.dart';
import 'package:seller/core/auth/bloc/event.dart';
import 'package:seller/modules/login/model/error/error_login.dart';
import 'package:seller/modules/login/model/input/input_login.dart';
import 'package:seller/modules/login/repo/repo_login.dart';
import 'package:flutter/foundation.dart';
import 'package:sstream/sstream.dart';

class LoginBLoc {
  LoginBLoc(this._repo) {
    if (kDebugMode) {
      // email.add('saller@gmail.com');
      // password.add('password');
      email.add('rosiandana91@gmail.com');
      password.add('rosiandana');
      // email.add('agungnurcahyo@gmail.com');
      // password.add('agungnurcahyo');
    }
  }

  final LoginRepo _repo;

  final email = "".stream;
  final password = "".stream;

  Future<void> login() async {
    try {
      final emailVal = email.value;
      if (emailVal == '') {
        throw LoginError();
      }
      final passVal = password.value;
      if (passVal == '') {
        throw LoginError();
      }
      final token = await _repo.login(
        LoginInput(
          email: emailVal,
          password: passVal,
          applicationType: 'seller',
        ),
      );
      AuthBloc().raise(EventAuthLogin(token));
    } catch (e) {
      rethrow;
    }
  }
}
