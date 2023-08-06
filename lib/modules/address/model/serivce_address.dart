import 'package:seller/modules/address/model/model_address.dart';

abstract class AddressService {
  Future<List<CountryModel>> getCountry();
  Future<List<ProvinceModel>> getProvince(String contryID);
  Future<List<CityModel>> getCity(String provinceID);
  Future<List<DistrictModel>> getDistrict(String cityID);
}
