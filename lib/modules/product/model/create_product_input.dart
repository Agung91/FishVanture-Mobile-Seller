import 'dart:convert';

import 'package:flutter/foundation.dart';

class CreateProductInput {
  final String budidayaID;
  final int estTonase;
  final DateTime estDate;
  final List<PriceModel> input;
  CreateProductInput({
    required this.budidayaID,
    required this.estTonase,
    required this.estDate,
    required this.input,
  });

  CreateProductInput copyWith({
    String? budidayaID,
    int? estTonase,
    DateTime? estDate,
    List<PriceModel>? input,
  }) {
    return CreateProductInput(
      budidayaID: budidayaID ?? this.budidayaID,
      estTonase: estTonase ?? this.estTonase,
      estDate: estDate ?? this.estDate,
      input: input ?? this.input,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'budidayaID': budidayaID,
      'estTonase': estTonase,
      'estDate': estDate.toUtc().toIso8601String(),
      'input': input.map((x) => x.toMap()).toList(),
    };
  }

  factory CreateProductInput.fromMap(Map<String, dynamic> map) {
    return CreateProductInput(
      budidayaID: map['budidayaID'] ?? '',
      estTonase: map['estTonase']?.toInt() ?? 0,
      estDate: DateTime.parse(map['estDate']),
      input: List<PriceModel>.from(
          map['input']?.map((x) => PriceModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateProductInput.fromJson(String source) =>
      CreateProductInput.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CreateProductInputModel(budidayaID: $budidayaID, estTonase: $estTonase, estDate: $estDate, input: $input)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CreateProductInput &&
        other.budidayaID == budidayaID &&
        other.estTonase == estTonase &&
        other.estDate == estDate &&
        listEquals(other.input, input);
  }

  @override
  int get hashCode {
    return budidayaID.hashCode ^
        estTonase.hashCode ^
        estDate.hashCode ^
        input.hashCode;
  }
}

class PriceModel {
  final int limit;
  final int price;
  PriceModel({
    required this.limit,
    required this.price,
  });

  PriceModel copyWith({
    int? limit,
    int? price,
  }) {
    return PriceModel(
      limit: limit ?? this.limit,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'limit': limit,
      'price': price,
    };
  }

  factory PriceModel.fromMap(Map<String, dynamic> map) {
    return PriceModel(
      limit: map['limit']?.toInt() ?? 0,
      price: map['price']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory PriceModel.fromJson(String source) =>
      PriceModel.fromMap(json.decode(source));

  @override
  String toString() => 'PriceModel(limit: $limit, price: $price)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PriceModel && other.limit == limit && other.price == price;
  }

  @override
  int get hashCode => limit.hashCode ^ price.hashCode;
}


// type CreateMultiplePriceListInput struct {
// 	BudidayaID uuid.UUID              `json:"budidayaID"`
// 	EstTonase  int                    `json:"estTonase"`
// 	EstDate    time.Time              `json:"estDate"`
// 	Input      []CreatePriceListInput `json:"input"`
// }

// type CreatePriceListInput struct {
// 	Limit      int       `json:"limit"`
// 	Price      int       `json:"price"`
// }
