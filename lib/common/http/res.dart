// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:seller/common/http/error.dart';
import 'package:flutter/foundation.dart';

import 'package:seller/common/errors/errors.dart';

class Responses {
  Responses({
    required this.status,
    this.id,
    this.data,
    this.message,
    this.error = const [],
  });
  final String status;
  final String? id;
  final dynamic data;
  final String? message;
  List<HttpError> error;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'id': id,
      'data': data,
      'message': message,
      'error': error.map((x) => x.toMap()).toList(),
    };
  }

  factory Responses.fromMap(Map<String, dynamic> map) {
    return Responses(
      status: map['status'] as String,
      id: map['id'] != null ? map['id'] as String : null,
      data: map['data'] != null ? map['data'] as dynamic : null,
      message: map['message'] != null ? map['message'] as String : null,
      error: map['error'] != null
          ? List<HttpError>.from(
              (map['error'] as List<dynamic>).map<Errors?>(
                (x) => HttpError.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory Responses.fromJson(String source) =>
      Responses.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Responses(status: $status, id: $id, data: $data, message: $message, error: $error)';
  }

  @override
  bool operator ==(covariant Responses other) {
    if (identical(this, other)) return true;

    return other.status == status &&
        other.id == id &&
        other.data == data &&
        other.message == message &&
        listEquals(other.error, error);
  }

  @override
  int get hashCode {
    return status.hashCode ^
        id.hashCode ^
        data.hashCode ^
        message.hashCode ^
        error.hashCode;
  }

  Responses copyWith({
    String? status,
    String? id,
    dynamic data,
    String? message,
    List<Errors>? error,
  }) {
    return Responses(
      status: status ?? this.status,
      id: id ?? this.id,
      data: data ?? this.data,
      message: message ?? this.message,
      error: error is HttpError ? this.error : [],
    );
  }
}
