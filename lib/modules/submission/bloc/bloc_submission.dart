import 'package:location/location.dart';
import 'package:seller/modules/submission/model/model_submission.dart';
import 'package:sstream/sstream.dart';

import 'package:seller/common/file_picker/model_upload_file.dart';
import 'package:seller/modules/address/model/model_address.dart';
import 'package:seller/modules/address/repo/repo_address.dart';
import 'package:seller/modules/pool/model/model_pool.dart';
import 'package:seller/modules/submission/repo/repo_submission.dart';

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
  final noteAddres = ''.stream;
  final type = 0.stream;
  final imagePond = ''.stream;
  final types = ['mandiri', 'team'];
  // final koordinat = ''.stream;
  final initialKoordinat = SStream<LocationData?>(null);

  Future<void> createPond() async {
    final nameVal = name.value;
    if (nameVal == '') {
      throw 'Field tidak boleh kosong';
    }
    final countryVal = country.value;
    if (countryVal == null) {
      throw 'Field tidak boleh kosong';
    }
    final provinceVal = province.value;
    if (provinceVal == null) {
      throw 'Field tidak boleh kosong';
    }
    final cityVal = city.value;
    if (cityVal == null) {
      throw 'Field tidak boleh kosong';
    }
    final districtVal = district.value;
    if (districtVal == null) {
      throw 'Field tidak boleh kosong';
    }
    final detailAddresVal = detailAddres.value;
    if (detailAddresVal == '') {
      throw 'Field tidak boleh kosong';
    }
    final noteAddresVal = noteAddres.value;
    if (noteAddresVal == '') {
      throw 'Field tidak boleh kosong';
    }
    final imagePondVal = imagePond.value;
    if (imagePondVal == '') {
      throw 'Field tidak boleh kosong';
    }

    final initialKoordinatVal = initialKoordinat.value;
    if (initialKoordinatVal == null) {
      throw 'Field lokasi tidak boleh kosong';
    }
    final listPoolVal = listPool.value;
    if (listPoolVal == null || listPoolVal.isEmpty) {
      throw 'Field kolam tidak boleh kosong';
    }
    final listFileVal = listFile.value;
    if (listFileVal == null || listFileVal.isEmpty) {
      throw 'Field berkas tidak boleh kosong';
    }
    try {
      await _repo.createPond(SubmissionModel(
        name: nameVal,
        countryID: countryVal.id,
        provinceID: provinceVal.id,
        cityID: cityVal.id,
        districtID: districtVal.id,
        detailAddress: detailAddresVal,
        noteAddress: noteAddresVal,
        type: types[type.value],
        latitude: initialKoordinatVal.latitude ?? 0,
        longitude: initialKoordinatVal.longitude ?? 0,
        image: imagePondVal,
        listPool: listPoolVal,
        listBerkas: listFileVal,
      ));
    } catch (e) {
      rethrow;
    }
  }

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
    try {
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
    } catch (e) {
      rethrow;
    }
  }

  void deletePool(String name) {
    final listPoolVal = listPool.value;
    listPoolVal.removeWhere((element) => element.name == name);
    listPool.add(listPoolVal);
  }

// ========= FILE ===========

  final file = SStream<FileModel?>(null);
  final listFile = SStream<List<FileModel>>([]);

  void addFile() {
    final listFileVal = listFile.value;
    final fileVal = file.value;
    if (fileVal == null) {
      throw 'Field tidak boleh kosong';
    }
    try {
      listFileVal.add(fileVal);
      file.add(null);
    } catch (e) {
      rethrow;
    }
  }
}
