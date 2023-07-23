import 'package:seller/modules/pond/model/model_pond.dart';
import 'package:sstream/sstream.dart';

import 'package:seller/modules/address/model/model_address.dart';
import 'package:seller/modules/address/repo/repo_address.dart';

class AddressBloc {
  AddressBloc(this._repo) {
    _repo.getCountry().then(
          (value) => countrys.add(value),
        );
    country.listen(
      (event) {
        province.add(null);
        provinces.add([]);
        city.add(null);
        citys.add([]);
        district.add(null);
        districts.add([]);
        if (event != null) {
          _repo.getProvince(event.id).then(provinces.add);
        }
      },
    );
    province.listen(
      (event) {
        city.add(null);
        citys.add([]);
        district.add(null);
        districts.add([]);
        if (event != null) {
          _repo.getCity(event.id).then(citys.add);
        }
      },
    );
    city.listen(
      (event) {
        district.add(null);
        districts.add([]);
        if (event != null) {
          _repo.getDistrict(event.id).then(districts.add);
        }
      },
    );
  }

  final AddressHttpRepo _repo;

  final countrys = SStream<List<CountryModel>>([]);
  final country = SStream<CountryModel?>(null);

  final provinces = SStream<List<ProvinceModel>>([]);
  final province = SStream<ProvinceModel?>(null);

  final citys = SStream<List<CityModel>>([]);
  final city = SStream<CityModel?>(null);

  final districts = SStream<List<DistrictModel>>([]);
  final district = SStream<DistrictModel?>(null);

  final name = ''.stream;
  final detailAddres = ''.stream;
}
