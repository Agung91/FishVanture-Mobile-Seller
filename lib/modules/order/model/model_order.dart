import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:seller/modules/budidaya/model/model_budidaya.dart';

class PaginatedOrder {
  final String? findBy;
  final String? keyword;
  final int limit;
  final int page;
  final String sort;
  final String? direction;
  final int totalRows;
  final int totalPage;
  final List<OrderModel> rows;
  PaginatedOrder({
    required this.findBy,
    required this.keyword,
    required this.limit,
    required this.page,
    required this.sort,
    this.direction,
    required this.totalRows,
    required this.totalPage,
    required this.rows,
  });

  PaginatedOrder copyWith({
    String? findBy,
    String? keyword,
    int? limit,
    int? page,
    String? sort,
    String? direction,
    int? totalRows,
    int? totalPage,
    List<OrderModel>? rows,
  }) {
    return PaginatedOrder(
      findBy: findBy ?? this.findBy,
      keyword: keyword ?? this.keyword,
      limit: limit ?? this.limit,
      page: page ?? this.page,
      sort: sort ?? this.sort,
      direction: direction ?? this.direction,
      totalRows: totalRows ?? this.totalRows,
      totalPage: totalPage ?? this.totalPage,
      rows: rows ?? this.rows,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'findBy': findBy,
      'keyword': keyword,
      'limit': limit,
      'page': page,
      'sort': sort,
      'direction': direction,
      'totalRows': totalRows,
      'totalPage': totalPage,
      'rows': rows.map((x) => x.toMap()).toList(),
    };
  }

  factory PaginatedOrder.fromMap(Map<String, dynamic> map) {
    return PaginatedOrder(
      findBy: map['findBy'] ?? '',
      keyword: map['keyword'] ?? '',
      limit: map['limit']?.toInt() ?? 0,
      page: map['page']?.toInt() ?? 0,
      sort: map['sort'] ?? '',
      direction: map['direction'],
      totalRows: map['totalRows']?.toInt() ?? 0,
      totalPage: map['totalPage']?.toInt() ?? 0,
      rows:
          List<OrderModel>.from(map['rows']?.map((x) => OrderModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory PaginatedOrder.fromJson(String source) =>
      PaginatedOrder.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PaginatedOrder(findBy: $findBy, keyword: $keyword, limit: $limit, page: $page, sort: $sort, direction: $direction, totalRows: $totalRows, totalPage: $totalPage, rows: $rows)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PaginatedOrder &&
        other.findBy == findBy &&
        other.keyword == keyword &&
        other.limit == limit &&
        other.page == page &&
        other.sort == sort &&
        other.direction == direction &&
        other.totalRows == totalRows &&
        other.totalPage == totalPage &&
        listEquals(other.rows, rows);
  }

  @override
  int get hashCode {
    return findBy.hashCode ^
        keyword.hashCode ^
        limit.hashCode ^
        page.hashCode ^
        sort.hashCode ^
        direction.hashCode ^
        totalRows.hashCode ^
        totalPage.hashCode ^
        rows.hashCode;
  }
}

class OrderModel {
  final String id;
  final String code;
  final String budidayaID;
  final BudidayaModel budidaya;
  final UserOrder user;
  final int qty;
  final DateTime bookingDate;
  final String pricelistID;
  final String pricelist;
  final int price;
  final int ammout;
  final String status;
  final DateTime createdAt;
  OrderModel({
    required this.id,
    required this.code,
    required this.budidayaID,
    required this.budidaya,
    required this.user,
    required this.qty,
    required this.bookingDate,
    required this.pricelistID,
    required this.pricelist,
    required this.price,
    required this.ammout,
    required this.status,
    required this.createdAt,
  });

  OrderModel copyWith({
    String? id,
    String? code,
    String? budidayaID,
    BudidayaModel? budidaya,
    UserOrder? user,
    int? qty,
    DateTime? bookingDate,
    String? pricelistID,
    String? pricelist,
    int? price,
    int? ammout,
    String? status,
    DateTime? createdAt,
  }) {
    return OrderModel(
      id: id ?? this.id,
      code: code ?? this.code,
      budidayaID: budidayaID ?? this.budidayaID,
      budidaya: budidaya ?? this.budidaya,
      user: user ?? this.user,
      qty: qty ?? this.qty,
      bookingDate: bookingDate ?? this.bookingDate,
      pricelistID: pricelistID ?? this.pricelistID,
      pricelist: pricelist ?? this.pricelist,
      price: price ?? this.price,
      ammout: ammout ?? this.ammout,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'code': code,
      'budidayaID': budidayaID,
      'budidaya': budidaya.toMap(),
      'user': user.toMap(),
      'qty': qty,
      'bookingDate': bookingDate.toUtc().toIso8601String(),
      'pricelistID': pricelistID,
      'pricelist': pricelist,
      'price': price,
      'ammout': ammout,
      'status': status,
      'createdAt': createdAt.toUtc().toIso8601String(),
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] ?? '',
      code: map['code'] ?? '',
      budidayaID: map['budidayaID'] ?? '',
      budidaya: BudidayaModel.fromMap(map['budidaya']),
      user: UserOrder.fromMap(map['user']),
      qty: map['qty']?.toInt() ?? 0,
      bookingDate: DateTime.parse(map['bookingDate']).toLocal(),
      pricelistID: map['pricelistID'] ?? '',
      pricelist: map['pricelist'] ?? '',
      price: map['price']?.toInt() ?? 0,
      ammout: map['ammout']?.toInt() ?? 0,
      status: map['status'] ?? '',
      createdAt: DateTime.parse(map['createdAt']).toLocal(),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrderModel(id: $id, code: $code, budidayaID: $budidayaID, budidaya: $budidaya, user: $user, qty: $qty, bookingDate: $bookingDate, pricelistID: $pricelistID, pricelist: $pricelist, price: $price, ammout: $ammout, status: $status, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderModel &&
        other.id == id &&
        other.code == code &&
        other.budidayaID == budidayaID &&
        other.budidaya == budidaya &&
        other.user == user &&
        other.qty == qty &&
        other.bookingDate == bookingDate &&
        other.pricelistID == pricelistID &&
        other.pricelist == pricelist &&
        other.price == price &&
        other.ammout == ammout &&
        other.status == status &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        code.hashCode ^
        budidayaID.hashCode ^
        budidaya.hashCode ^
        user.hashCode ^
        qty.hashCode ^
        bookingDate.hashCode ^
        pricelistID.hashCode ^
        pricelist.hashCode ^
        price.hashCode ^
        ammout.hashCode ^
        status.hashCode ^
        createdAt.hashCode;
  }
}

class UserOrder {
  final String id;
  final String name;
  UserOrder({
    required this.id,
    required this.name,
  });

  UserOrder copyWith({
    String? id,
    String? name,
  }) {
    return UserOrder(
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

  factory UserOrder.fromMap(Map<String, dynamic> map) {
    return UserOrder(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserOrder.fromJson(String source) =>
      UserOrder.fromMap(json.decode(source));

  @override
  String toString() => 'UserOrder(id: $id, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserOrder && other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
