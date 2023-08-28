import 'package:seller/core/auth/bloc/authenticated.dart';
import 'package:seller/modules/home/model/model_status.dart';
import 'package:seller/modules/pond/model/model_pond.dart';
import 'package:seller/modules/pond/model/pond_id.dart';
import 'package:seller/modules/pond/repo/repo_pond.dart';
import 'package:sstream/sstream.dart';

class PondBloc extends Authenticated {
  // PondBloc(this._repo);
  PondBloc._();
  static final PondBloc _instance = PondBloc._();
  factory PondBloc() {
    return _instance;
  }
  final PondHttpRepo _repo = PondHttpRepo();

  final ponds = SStream<PondModel?>(null);
  final status = ''.stream;

  // bool get isAuthenticated => _state.value is StateLogin;
  bool get isValidate => status.value == StatusSubmission.actived;

  Future<void> getPond() async {
    try {
      final response = await _repo.getPond();
      ponds.add(response);
      status.add(response?.status ?? '');
      // save pond id
      PondID().addId(response?.id);
    } catch (e) {
      rethrow;
    }
  }

  void _makeEmpty() {
    ponds.add(null);
    status.add('');
  }

  @override
  Future<void> onLogin() async {
    getPond();
  }

  @override
  Future<void> onLogout() async {
    _makeEmpty();
    PondID().addId(null);
  }
}
