import 'package:seller/core/auth/bloc/auth_state.dart';
import 'package:seller/core/auth/bloc/event.dart';
import 'package:seller/core/auth/model/token.dart';
import 'package:sstream/sstream.dart';

class AuthBloc {
  //make singleton
  AuthBloc._();

  static final AuthBloc _instance = AuthBloc._();
  factory AuthBloc() {
    return _instance;
  }

  final SStream<StateAuth?> _state = SStream(null);
  Stream<StateAuth?> get state => _state.stream;

  AuthToken? getToken() {
    final latest = _state.value;
    if (latest is StateLogin) {
      return latest.token;
    }
    return null;
  }

  bool get isAuthenticated => _state.value is StateLogin;

  raise(AuthEvent event) {
    if (event is EventAuthLogin) {
      _state.add(StateLogin(token: event.token));
    } else if (event is EventAuthLogout) {
      _state.add(StateLogout());
    }
  }
}
