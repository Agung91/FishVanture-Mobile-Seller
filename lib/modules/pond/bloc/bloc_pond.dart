import 'package:seller/core/auth/bloc/authenticated.dart';
import 'package:seller/modules/pond/model/model_pond.dart';
import 'package:seller/modules/pond/repo/repo_pond.dart';
import 'package:sstream/sstream.dart';

class PondBloc extends Authenticated {
  PondBloc(this._repo);
  final PondHttpRepo _repo;

  final ponds = SStream<PondModel?>(null);
  final status = ''.stream;

  Future<void> getPond() async {
    try {
      final response = await _repo.getPond();
      ponds.add(response);
      status.add(response?.status ?? '');
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
  }
}
