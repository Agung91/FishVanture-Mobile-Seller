import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:seller/common/widgets/dropdown/dropdown.dart';

import 'package:seller/modules/budidaya/model/model_budidaya.dart';

class FishModel extends DropItem {
  final String id;
  final String name;
  final String asal;
  final List<BudidayaModel>? budidaya;
  FishModel({
    required this.id,
    required this.name,
    required this.asal,
    this.budidaya,
  });

  FishModel copyWith({
    String? id,
    String? name,
    String? asal,
    List<BudidayaModel>? budidaya,
  }) {
    return FishModel(
      id: id ?? this.id,
      name: name ?? this.name,
      asal: asal ?? this.asal,
      budidaya: budidaya ?? this.budidaya,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'asal': asal,
      'budidaya': budidaya?.map((x) => x.toMap()).toList(),
    };
  }

  factory FishModel.fromMap(Map<String, dynamic> map) {
    return FishModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      asal: map['asal'] ?? '',
      budidaya: map['budidaya'] != null
          ? List<BudidayaModel>.from(
              map['budidaya']?.map((x) => BudidayaModel.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FishModel.fromJson(String source) =>
      FishModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FishModel(id: $id, name: $name, asal: $asal, budidaya: $budidaya)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FishModel &&
        other.id == id &&
        other.name == name &&
        other.asal == asal &&
        listEquals(other.budidaya, budidaya);
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ asal.hashCode ^ budidaya.hashCode;
  }

  @override
  String label() => name;

  @override
  value() => id;
}
