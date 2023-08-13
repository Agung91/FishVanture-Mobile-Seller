import 'dart:convert';

import 'package:seller/common/widgets/dropdown/dropdown.dart';
import 'package:seller/modules/pond/model/model_pond.dart';

class PoolModel extends DropItem {
  final String? id;
  final String name;
  final double long;
  final double wide;
  final String image;
  final String? pondID;
  final PondModel? pond;
  PoolModel({
    this.id,
    required this.name,
    required this.long,
    required this.wide,
    required this.image,
    this.pondID,
    this.pond,
  });

  PoolModel copyWith({
    String? id,
    String? name,
    double? long,
    double? wide,
    String? image,
    String? pondID,
    PondModel? pond,
  }) {
    return PoolModel(
      id: id ?? this.id,
      name: name ?? this.name,
      long: long ?? this.long,
      wide: wide ?? this.wide,
      image: image ?? this.image,
      pondID: pondID ?? this.pondID,
      pond: pond ?? this.pond,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'long': long,
      'wide': wide,
      'image': image,
      'pondID': pondID,
      'pond': pond?.toMap(),
    };
  }

  factory PoolModel.fromMap(Map<String, dynamic> map) {
    return PoolModel(
      id: map['id'],
      name: map['name'] ?? '',
      long: map['long']?.toDouble() ?? 0.0,
      wide: map['wide']?.toDouble() ?? 0.0,
      image: map['image'] ?? '',
      pondID: map['pondID'],
      pond: map['pond'] != null ? PondModel.fromMap(map['pond']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PoolModel.fromJson(String source) =>
      PoolModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PoolModel(id: $id, name: $name, long: $long, wide: $wide, image: $image, pondID: $pondID, pond: $pond)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PoolModel &&
        other.id == id &&
        other.name == name &&
        other.long == long &&
        other.wide == wide &&
        other.image == image &&
        other.pondID == pondID &&
        other.pond == pond;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        long.hashCode ^
        wide.hashCode ^
        image.hashCode ^
        pondID.hashCode ^
        pond.hashCode;
  }

  @override
  String label() => name;

  @override
  value() => id;
}
