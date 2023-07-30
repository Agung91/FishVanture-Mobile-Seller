import 'dart:io';

import 'package:location/location.dart';
import 'package:seller/common/file_picker/model_upload_file.dart';
import 'package:seller/modules/address/model/model_address.dart';
import 'package:seller/modules/address/repo/repo_address.dart';
import 'package:seller/modules/pool/model/model_pool.dart';
import 'package:seller/modules/submission/repo/repo_submission.dart';
import 'package:sstream/sstream.dart';

class SubmissionBloc {
  SubmissionBloc(this._repo, this._repoAddress) {
    _repoAddress.getCountry().then(
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
          _repoAddress.getProvince(event.id).then(provinces.add);
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
          _repoAddress.getCity(event.id).then(citys.add);
        }
      },
    );
    city.listen(
      (event) {
        district.add(null);
        districts.add([]);
        if (event != null) {
          _repoAddress.getDistrict(event.id).then(districts.add);
        }
      },
    );
  }

  final AddressHttpRepo _repoAddress;
  final SubmissionHttpRepo _repo;

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
  final koordinat = ''.stream;
  final initialKoordinat = SStream<LocationData?>(null);

// ========= Pool ===========
  final listPool = SStream<List<PoolModel>>([]);

  final poolName = "".stream;
  final poolLength = ''.stream;
  final poolWidth = ''.stream;
  final poolImage = ''.stream;

  void addPool() {
    final listPoolVal = listPool.value;
    final poolNameVal = poolName.value;
    if (poolNameVal == '') {
      throw 'Field tidak boleh kosong';
    }
    final poolLengthVal = poolLength.value;
    if (poolLengthVal == '') {
      throw 'Field tidak boleh kosong';
    }
    final poolWidthVal = poolWidth.value;
    if (poolWidthVal == '') {
      throw 'Field tidak boleh kosong';
    }
    final poolImageVal = poolImage.value;
    if (poolImageVal == '') {
      throw 'Field tidak boleh kosong';
    }
    listPoolVal.add(
      PoolModel(
        name: poolNameVal,
        long: double.parse(poolLengthVal),
        wide: double.parse(poolWidthVal),
        image: poolImageVal,
      ),
    );
    poolName.add('');
    poolLength.add('');
    poolWidth.add('');
    poolImage.add('');
    listPool.add(listPoolVal);
  }

  void deletePool(String name) {
    final listPoolVal = listPool.value;
    listPoolVal.removeWhere((element) => element.name == name);
    listPool.add(listPoolVal);
  }

// ========= FILE ===========

  final file = SStream<FileModel?>(null);

}
