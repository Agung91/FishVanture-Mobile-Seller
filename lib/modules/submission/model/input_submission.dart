import 'dart:convert';

import 'package:collection/collection.dart';

import 'package:seller/common/file_picker/model_upload_file.dart';
import 'package:seller/modules/pool/model/model_pool.dart';

class SubmissionInput {
  final String name;
  final String countryID;
  final String provinceID;
  final String cityID;
  final String districtID;
  final String detailAddress;
  final String noteAddress;
  final String type;
  final double latitude;
  final double longitude;
  final String teamID;
  final String image;
  final List<PoolModel> listPool;
  final List<FileModel> listBerkas;

  SubmissionInput({
    required this.name,
    required this.countryID,
    required this.provinceID,
    required this.cityID,
    required this.districtID,
    required this.detailAddress,
    required this.noteAddress,
    required this.type,
    required this.latitude,
    required this.longitude,
    required this.teamID,
    required this.image,
    required this.listPool,
    required this.listBerkas,
  });

  SubmissionInput copyWith({
    String? name,
    String? countryID,
    String? provinceID,
    String? cityID,
    String? districtID,
    String? detailAddress,
    String? noteAddress,
    String? type,
    double? latitude,
    double? longitude,
    String? teamID,
    String? image,
    List<PoolModel>? listPool,
    List<FileModel>? listBerkas,
  }) {
    return SubmissionInput(
      name: name ?? this.name,
      countryID: countryID ?? this.countryID,
      provinceID: provinceID ?? this.provinceID,
      cityID: cityID ?? this.cityID,
      districtID: districtID ?? this.districtID,
      detailAddress: detailAddress ?? this.detailAddress,
      noteAddress: noteAddress ?? this.noteAddress,
      type: type ?? this.type,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      teamID: teamID ?? this.teamID,
      image: image ?? this.image,
      listPool: listPool ?? this.listPool,
      listBerkas: listBerkas ?? this.listBerkas,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'countryID': countryID,
      'provinceID': provinceID,
      'cityID': cityID,
      'districtID': districtID,
      'detailAddress': detailAddress,
      'noteAddress': noteAddress,
      'type': type,
      'latitude': latitude,
      'longitude': longitude,
      'teamID': teamID,
      'image': image,
      'listPool': listPool.map((x) => x.toMap()).toList(),
      'listBerkas': listBerkas.map((x) => x.toMap()).toList(),
    };
  }

  factory SubmissionInput.fromMap(Map<String, dynamic> map) {
    return SubmissionInput(
      name: map['name'] ?? '',
      countryID: map['countryID'] ?? '',
      provinceID: map['provinceID'] ?? '',
      cityID: map['cityID'] ?? '',
      districtID: map['districtID'] ?? '',
      detailAddress: map['detailAddress'] ?? '',
      noteAddress: map['noteAddress'] ?? '',
      type: map['type'] ?? '',
      latitude: map['latitude']?.toDouble() ?? 0.0,
      longitude: map['longitude']?.toDouble() ?? 0.0,
      teamID: map['teamID'] ?? '',
      image: map['image'] ?? '',
      listPool: List<PoolModel>.from(
          map['listPool']?.map((x) => PoolModel.fromMap(x))),
      listBerkas: List<FileModel>.from(
          map['listBerkas']?.map((x) => FileModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory SubmissionInput.fromJson(String source) =>
      SubmissionInput.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SubmissionInput(name: $name, countryID: $countryID, provinceID: $provinceID, cityID: $cityID, districtID: $districtID, detailAddress: $detailAddress, noteAddress: $noteAddress, type: $type, latitude: $latitude, longitude: $longitude, teamID: $teamID, image: $image, listPool: $listPool, listBerkas: $listBerkas)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is SubmissionInput &&
        other.name == name &&
        other.countryID == countryID &&
        other.provinceID == provinceID &&
        other.cityID == cityID &&
        other.districtID == districtID &&
        other.detailAddress == detailAddress &&
        other.noteAddress == noteAddress &&
        other.type == type &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.teamID == teamID &&
        other.image == image &&
        listEquals(other.listPool, listPool) &&
        listEquals(other.listBerkas, listBerkas);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        countryID.hashCode ^
        provinceID.hashCode ^
        cityID.hashCode ^
        districtID.hashCode ^
        detailAddress.hashCode ^
        noteAddress.hashCode ^
        type.hashCode ^
        latitude.hashCode ^
        longitude.hashCode ^
        teamID.hashCode ^
        image.hashCode ^
        listPool.hashCode ^
        listBerkas.hashCode;
  }
}
