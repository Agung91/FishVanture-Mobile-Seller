import 'package:seller/modules/fish/model/model_fish.dart';
import 'package:seller/modules/pool/model/input_create_pool.dart';

abstract class FishService {
  Future<String?> createFish(CreatePoolInput input);
  Future<List<FishModel>> getFishes();
}
