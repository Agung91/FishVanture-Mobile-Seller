import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:seller/modules/budidaya/model/model_price_list.dart';

class UpdateProductInput {
  final String budidayaID;
  final int estTonase;
  final DateTime estDate;
  final List<PriceListModel> pricelist;
  UpdateProductInput({
    required this.budidayaID,
    required this.estTonase,
    required this.estDate,
    required this.pricelist,
  });

  UpdateProductInput copyWith({
    String? budidayaID,
    int? estTonase,
    DateTime? estDate,
    List<PriceListModel>? pricelist,
  }) {
    return UpdateProductInput(
      budidayaID: budidayaID ?? this.budidayaID,
      estTonase: estTonase ?? this.estTonase,
      estDate: estDate ?? this.estDate,
      pricelist: pricelist ?? this.pricelist,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'budidayaID': budidayaID,
      'estTonase': estTonase,
      'estDate': estDate..toUtc().toIso8601String(),
      'pricelist': pricelist.map((x) => x.toMap()).toList(),
    };
  }

  factory UpdateProductInput.fromMap(Map<String, dynamic> map) {
    return UpdateProductInput(
      budidayaID: map['budidayaID'] ?? '',
      estTonase: map['estTonase']?.toInt() ?? 0,
      estDate: DateTime.parse(map['estDate']).toLocal(),
      pricelist: List<PriceListModel>.from(
          map['pricelist']?.map((x) => PriceListModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory UpdateProductInput.fromJson(String source) =>
      UpdateProductInput.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UpdateProductInput(budidayaID: $budidayaID, estTonase: $estTonase, estDate: $estDate, pricelist: $pricelist)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UpdateProductInput &&
        other.budidayaID == budidayaID &&
        other.estTonase == estTonase &&
        other.estDate == estDate &&
        listEquals(other.pricelist, pricelist);
  }

  @override
  int get hashCode {
    return budidayaID.hashCode ^
        estTonase.hashCode ^
        estDate.hashCode ^
        pricelist.hashCode;
  }
}
