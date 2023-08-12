import 'package:seller/common/http/http.dart';
import 'package:seller/config/hosts.dart';
import 'package:seller/modules/fish/model/input_create_fish.dart';
import 'package:seller/modules/fish/model/model_fish.dart';
import 'package:seller/modules/fish/model/service_fish.dart';
import 'package:seller/modules/pool/model/service_pool.dart';

class FishHttpRepo extends HttpService implements FishService {
  @override
  Future<String?> createFish(CreateFishInput input) async {
    try {
      final response =
          await post('$host/create-fish-species', body: input.toMap());
      return response.id;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<FishModel>> getFishes() async {
    try {
      final response = await get('$host/list-fish-species');
      if (response is List) {
        return List<Map<String, dynamic>>.from(response)
            .map((e) => FishModel.fromMap(e))
            .toList();
      }
      throw 'Can\'t parse fish model';
    } catch (e) {
      rethrow;
    }
  }
}
