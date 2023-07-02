import 'dart:convert';

import 'package:seller/common/errors/errors.dart';

const Errors errFailedToParseResponeData = HttpError(message: "");
const Errors errFailedToParseResponeID = HttpError(message: "");

class HttpError extends Errors {
  const HttpError({
    super.code,
    required super.message,
    super.detail,
  });

  @override
  String toString() =>
      'Errors(code: $code, message: $message, detail: $detail)';

  @override
  bool operator ==(covariant Errors other) {
    if (identical(this, other)) return true;

    return other.code == code &&
        other.message == message &&
        other.detail == detail;
  }

  @override
  int get hashCode => code.hashCode ^ message.hashCode ^ detail.hashCode;

  HttpError copyWith({
    String? code,
    String? message,
    String? detail,
  }) {
    return HttpError(
      code: code ?? this.code,
      message: message ?? this.message,
      detail: detail ?? this.detail,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code': code,
      'message': message,
      'detail': detail,
    };
  }

  factory HttpError.fromMap(Map<String, dynamic> map) {
    return HttpError(
      code: map['code'] != null ? map['code'] as String : null,
      message: map['message'] as String,
      detail: map['detail'] != null ? map['detail'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory HttpError.fromJson(String source) =>
      HttpError.fromMap(json.decode(source) as Map<String, dynamic>);
}
