// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:seller/core/auth/model/token.dart';

class TokenData extends AuthToken {
  TokenData({
    required String token,
  }) : super(token: token);

  TokenData copyWith({
    String? token,
  }) {
    return TokenData(
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
    };
  }

  factory TokenData.fromSuper(AuthToken map) {
    return TokenData(
      token: map.token,
    );
  }
  factory TokenData.fromMap(Map<String, dynamic> map) {
    return TokenData(
      token: map['token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TokenData.fromJson(String source) =>
      TokenData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => '_Token(token: $token)';

  @override
  bool operator ==(covariant TokenData other) {
    if (identical(this, other)) return true;

    return other.token == token;
  }

  @override
  int get hashCode => token.hashCode;
}
