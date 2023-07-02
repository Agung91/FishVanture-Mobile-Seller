import 'package:seller/core/auth/bloc/auth_state.dart';
import 'package:seller/core/auth/bloc/bloc_auth.dart';

abstract class Authenticated {
  Authenticated() {
    AuthBloc().state.listen((state) {
      if (state is StateLogin) {
        onLogin();
      } else if (state is StateLogout) {
        onLogout();
      }
    });
    if (AuthBloc().isAuthenticated) {
      onLogin();
    }
  }

  Future<void> onLogin();
  Future<void> onLogout();
}
