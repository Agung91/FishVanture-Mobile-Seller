import 'dart:convert';

import 'package:seller/common/widgets/dropdown/dropdown.dart';

class CountryModel extends DropItem {
  final String id;
  final String name;
  CountryModel({
    required this.id,
    required this.name,
  });

  CountryModel copyWith({
    String? id,
    String? name,
  }) {
    return CountryModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory CountryModel.fromMap(Map<String, dynamic> map) {
    return CountryModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CountryModel.fromJson(String source) =>
      CountryModel.fromMap(json.decode(source));

  @override
  String toString() => 'CountryModel(id: $id, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CountryModel && other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  @override
  String label() => name;

  @override
  value() {
    this;
  }
}

class ProvinceModel extends DropItem {
  final String countryID;
  final String id;
  final String name;
  ProvinceModel({
    required this.countryID,
    required this.id,
    required this.name,
  });

  ProvinceModel copyWith({
    String? countryID,
    String? id,
    String? name,
  }) {
    return ProvinceModel(
      countryID: countryID ?? this.countryID,
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'countryID': countryID,
      'id': id,
      'name': name,
    };
  }

  factory ProvinceModel.fromMap(Map<String, dynamic> map) {
    return ProvinceModel(
      countryID: map['countryID'] ?? '',
      id: map['id'] ?? '',
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ProvinceModel.fromJson(String source) =>
      ProvinceModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'ProvinceModel(countryID: $countryID, id: $id, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProvinceModel &&
        other.countryID == countryID &&
        other.id == id &&
        other.name == name;
  }

  @override
  int get hashCode => countryID.hashCode ^ id.hashCode ^ name.hashCode;

  @override
  String label() => name;

  @override
  value() {
    this;
  }
}

class CityModel extends DropItem {
  final String provinceID;
  final String id;
  final String name;
  CityModel({
    required this.provinceID,
    required this.id,
    required this.name,
  });

  CityModel copyWith({
    String? provinceID,
    String? id,
    String? name,
  }) {
    return CityModel(
      provinceID: provinceID ?? this.provinceID,
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'provinceID': provinceID,
      'id': id,
      'name': name,
    };
  }

  factory CityModel.fromMap(Map<String, dynamic> map) {
    return CityModel(
      provinceID: map['provinceID'] ?? '',
      id: map['id'] ?? '',
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CityModel.fromJson(String source) =>
      CityModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'CityModel(provinceID: $provinceID, id: $id, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CityModel &&
        other.provinceID == provinceID &&
        other.id == id &&
        other.name == name;
  }

  @override
  int get hashCode => provinceID.hashCode ^ id.hashCode ^ name.hashCode;

  @override
  String label() => name;

  @override
  value() {
    this;
  }
}

class DistrictModel extends DropItem {
  final String cityID;
  final String id;
  final String name;
  DistrictModel({
    required this.cityID,
    required this.id,
    required this.name,
  });

  DistrictModel copyWith({
    String? cityID,
    String? id,
    String? name,
  }) {
    return DistrictModel(
      cityID: cityID ?? this.cityID,
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cityID': cityID,
      'id': id,
      'name': name,
    };
  }

  factory DistrictModel.fromMap(Map<String, dynamic> map) {
    return DistrictModel(
      cityID: map['cityID'] ?? '',
      id: map['id'] ?? '',
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory DistrictModel.fromJson(String source) =>
      DistrictModel.fromMap(json.decode(source));

  @override
  String toString() => 'DistrictModel(cityID: $cityID, id: $id, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DistrictModel &&
        other.cityID == cityID &&
        other.id == id &&
        other.name == name;
  }

  @override
  int get hashCode => cityID.hashCode ^ id.hashCode ^ name.hashCode;

  @override
  String label() => name;

  @override
  value() {
    this;
  }
}
