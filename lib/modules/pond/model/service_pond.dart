import 'package:seller/modules/pond/model/model_pond.dart';

abstract class PondService {
  Future<PondModel?> getPond();
}
