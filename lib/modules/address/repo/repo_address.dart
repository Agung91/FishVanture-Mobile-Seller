import 'package:seller/common/http/http.dart';
import 'package:seller/config/hosts.dart';
import 'package:seller/modules/address/model/model_address.dart';
import 'package:seller/modules/address/model/serivce_address.dart';

class AddressHttpRepo extends HttpService implements AddressService {
  @override
  Future<List<CityModel>> getCity(String provinceID) async {
    try {
      final response = await get('$host/list-city-province?id=$provinceID');
      if (response is List) {
        return List<Map<String, dynamic>>.from(response)
            .map((e) => CityModel.fromMap(e))
            .toList();
      }
      throw 'Can\'t parse city model';
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<CountryModel>> getCountry() async {
    try {
      final response = await get('$host/list-country');
      if (response is List) {
        return List<Map<String, dynamic>>.from(response)
            .map((e) => CountryModel.fromMap(e))
            .toList();
      }
      throw 'Can\'t parse country model';
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<DistrictModel>> getDistrict(String cityID) async {
    try {
      final response = await get('$host/list-district-city?id=$cityID');
      if (response is List) {
        return List<Map<String, dynamic>>.from(response)
            .map((e) => DistrictModel.fromMap(e))
            .toList();
      }
      throw 'Can\'t parse dictrict model';
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ProvinceModel>> getProvince(String contryID) async {
    try {
      final response = await get('$host/list-province-country?id=$contryID');
      if (response is List) {
        return List<Map<String, dynamic>>.from(response)
            .map((e) => ProvinceModel.fromMap(e))
            .toList();
      }
      throw 'Can\'t parse dictrict model';
    } catch (e) {
      rethrow;
    }
  }
}
