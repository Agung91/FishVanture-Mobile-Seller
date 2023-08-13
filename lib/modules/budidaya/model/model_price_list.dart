import 'dart:convert';

class PriceListModel {
  final String? id;
  final String? budidayaID;
  final String? budidaya;
  final int? limit;
  final int? price;
  PriceListModel({
    this.id,
    required this.budidayaID,
    required this.budidaya,
    required this.limit,
    required this.price,
  });

  PriceListModel copyWith({
    String? id,
    String? budidayaID,
    String? budidaya,
    int? limit,
    int? price,
  }) {
    return PriceListModel(
      id: id ?? this.id,
      budidayaID: budidayaID ?? this.budidayaID,
      budidaya: budidaya ?? this.budidaya,
      limit: limit ?? this.limit,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'budidayaID': budidayaID,
      'budidaya': budidaya,
      'limit': limit,
      'price': price,
    };
  }

  factory PriceListModel.fromMap(Map<String, dynamic> map) {
    return PriceListModel(
      id: map['id'],
      budidayaID: map['budidayaID'],
      budidaya: map['budidaya'],
      limit: map['limit']?.toInt(),
      price: map['price']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory PriceListModel.fromJson(String source) =>
      PriceListModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PriceListModel(id: $id, budidayaID: $budidayaID, budidaya: $budidaya, limit: $limit, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PriceListModel &&
        other.id == id &&
        other.budidayaID == budidayaID &&
        other.budidaya == budidaya &&
        other.limit == limit &&
        other.price == price;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        budidayaID.hashCode ^
        budidaya.hashCode ^
        limit.hashCode ^
        price.hashCode;
  }
}
