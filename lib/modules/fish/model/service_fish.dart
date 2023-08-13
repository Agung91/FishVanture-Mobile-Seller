import 'package:seller/modules/fish/model/input_create_fish.dart';
import 'package:seller/modules/fish/model/model_fish.dart';

abstract class FishService {
  Future<String?> createFish(CreateFishInput input);
  Future<List<FishModel>> getFishes();
}
