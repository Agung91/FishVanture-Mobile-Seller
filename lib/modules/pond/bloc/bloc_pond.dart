import 'package:seller/modules/pond/model/model_pond.dart';
import 'package:seller/modules/pond/repo/repo_pond.dart';
import 'package:sstream/sstream.dart';

class PondBloc {
  PondBloc(this._repo) {
    getPond();
  }
  final PondHttpRepo _repo;

  final ponds = SStream<PondModel?>(null);

  Future<void> getPond() async {
    try {
      final response = await _repo.getPond();
      ponds.add(response);
    } catch (e) {
      rethrow;
    }
  }
}
