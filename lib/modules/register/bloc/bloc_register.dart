import 'package:seller/modules/register/model/input/input_register.dart';
import 'package:seller/modules/register/repo/repo_register.dart';
import 'package:sstream/sstream.dart';

class RegisterBloc {
  RegisterBloc(this._repo);

  final RegisterRepo _repo;

  final name = "".stream;
  final email = "".stream;
  final password = "".stream;
  final konfirmPassword = "".stream;

  Future<void> register() async {
    try {
      final nameVal = name.value;
      if (nameVal == '') {
        throw 'error';
      }
      final emailVal = email.value;
      if (emailVal == '') {
        throw 'error';
      }
      final passVal = password.value;
      if (passVal == '') {
        throw 'error';
      }
      final konfirmPassVal = konfirmPassword.value;
      if (konfirmPassVal == '') {
        throw 'error';
      }
      if (passVal != konfirmPassVal) {
        throw 'error';
      }
      await _repo.register(
        RegsiterInput(
          name: nameVal,
          email: emailVal,
          password: passVal,
          applicationType: 'seller',
        ),
      );
    } catch (e) {
      rethrow;
    }
  }
}
