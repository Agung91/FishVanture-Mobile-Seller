import 'package:seller/modules/address/model/model_address.dart';
import 'package:sstream/sstream.dart';

class AddressBloc {
  final countrys = SStream<List<CountryModel>>([]);
  final country = SStream<CountryModel?>(null);

  final provinces = SStream<List<ProvinceModel>>([]);
  final province = SStream<ProvinceModel?>(null);

  final citys = SStream<List<CityModel>>([]);
  final city = SStream<CityModel?>(null);

  final districts = SStream<List<DistrictModel>>([]);
  final district = SStream<DistrictModel?>(null);
}
