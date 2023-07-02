import 'package:seller/modules/register/model/input/input_register.dart';

abstract class RegsiterService {
  Future<String?> register(RegsiterInput input);
}
