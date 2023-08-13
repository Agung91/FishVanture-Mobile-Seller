import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:seller/modules/budidaya/model/model_price_list.dart';
import 'package:seller/modules/fish/model/model_fish.dart';
import 'package:seller/modules/pool/model/model_pool.dart';

class BudidayaModel {
  final String id;
  final String pondID;
  final String poolID;
  final PoolModel pool;
  final DateTime dateOfSeed;
  final String fishSpeciesID;
  final FishModel fishSpecies;
  final String? fishSpeciesName;
  final double? estTonase;
  final DateTime? estPanenDate;
  final int? estPrice;
  final String status;
  final List<PriceListModel>? priceList;
  BudidayaModel({
    required this.id,
    required this.pondID,
    required this.poolID,
    required this.pool,
    required this.dateOfSeed,
    required this.fishSpeciesID,
    required this.fishSpecies,
    this.fishSpeciesName,
    required this.estTonase,
    this.estPanenDate,
    this.estPrice,
    required this.status,
    this.priceList,
  });

  BudidayaModel copyWith({
    String? id,
    String? pondID,
    String? poolID,
    PoolModel? pool,
    DateTime? dateOfSeed,
    String? fishSpeciesID,
    FishModel? fishSpecies,
    String? fishSpeciesName,
    double? estTonase,
    DateTime? estPanenDate,
    int? estPrice,
    String? status,
    List<PriceListModel>? priceList,
  }) {
    return BudidayaModel(
      id: id ?? this.id,
      pondID: pondID ?? this.pondID,
      poolID: poolID ?? this.poolID,
      pool: pool ?? this.pool,
      dateOfSeed: dateOfSeed ?? this.dateOfSeed,
      fishSpeciesID: fishSpeciesID ?? this.fishSpeciesID,
      fishSpecies: fishSpecies ?? this.fishSpecies,
      fishSpeciesName: fishSpeciesName ?? this.fishSpeciesName,
      estTonase: estTonase ?? this.estTonase,
      estPanenDate: estPanenDate ?? this.estPanenDate,
      estPrice: estPrice ?? this.estPrice,
      status: status ?? this.status,
      priceList: priceList ?? this.priceList,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'pondID': pondID,
      'poolID': poolID,
      'pool': pool.toMap(),
      'dateOfSeed': dateOfSeed.toUtc().toIso8601String(),
      'fishSpeciesID': fishSpeciesID,
      'fishSpecies': fishSpecies.toMap(),
      'fishSpeciesName': fishSpeciesName,
      'estTonase': estTonase,
      'estPanenDate': estPanenDate?.toUtc().toIso8601String(),
      'estPrice': estPrice,
      'status': status,
      'priceList': priceList?.map((x) => x.toMap()).toList(),
    };
  }

  factory BudidayaModel.fromMap(Map<String, dynamic> map) {
    return BudidayaModel(
      id: map['id'] ?? '',
      pondID: map['pondID'] ?? '',
      poolID: map['poolID'] ?? '',
      pool: PoolModel.fromMap(map['pool']),
      dateOfSeed: DateTime.parse(map['dateOfSeed']),
      fishSpeciesID: map['fishSpeciesID'] ?? '',
      fishSpecies: FishModel.fromMap(map['fishSpecies']),
      fishSpeciesName: map['fishSpeciesName'],
      estTonase: map['estTonase']?.toDouble(),
      estPanenDate: map['estPanenDate'] != null
          ? DateTime.parse(map['estPanenDate'])
          : null,
      estPrice: map['estPrice']?.toInt(),
      status: map['status'] ?? '',
      priceList: map['priceList'] != null
          ? List<PriceListModel>.from(
              map['priceList']?.map((x) => PriceListModel.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BudidayaModel.fromJson(String source) =>
      BudidayaModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BudidayaModel(id: $id, pondID: $pondID, poolID: $poolID, pool: $pool, dateOfSeed: $dateOfSeed, fishSpeciesID: $fishSpeciesID, fishSpecies: $fishSpecies, fishSpeciesName: $fishSpeciesName, estTonase: $estTonase, estPanenDate: $estPanenDate, estPrice: $estPrice, status: $status, priceList: $priceList)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BudidayaModel &&
        other.id == id &&
        other.pondID == pondID &&
        other.poolID == poolID &&
        other.pool == pool &&
        other.dateOfSeed == dateOfSeed &&
        other.fishSpeciesID == fishSpeciesID &&
        other.fishSpecies == fishSpecies &&
        other.fishSpeciesName == fishSpeciesName &&
        other.estTonase == estTonase &&
        other.estPanenDate == estPanenDate &&
        other.estPrice == estPrice &&
        other.status == status &&
        listEquals(other.priceList, priceList);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        pondID.hashCode ^
        poolID.hashCode ^
        pool.hashCode ^
        dateOfSeed.hashCode ^
        fishSpeciesID.hashCode ^
        fishSpecies.hashCode ^
        fishSpeciesName.hashCode ^
        estTonase.hashCode ^
        estPanenDate.hashCode ^
        estPrice.hashCode ^
        status.hashCode ^
        priceList.hashCode;
  }
}
