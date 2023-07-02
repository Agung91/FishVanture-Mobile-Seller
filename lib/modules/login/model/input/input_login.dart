import 'dart:convert';

class LoginInput {
  final String email;
  final String password;
  final String applicationType;
  LoginInput({
    required this.email,
    required this.password,
    required this.applicationType,
  });

  LoginInput copyWith({
    String? email,
    String? password,
    String? applicationType,
  }) {
    return LoginInput(
      email: email ?? this.email,
      password: password ?? this.password,
      applicationType: applicationType ?? this.applicationType,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'applicationType': applicationType,
    };
  }

  factory LoginInput.fromMap(Map<String, dynamic> map) {
    return LoginInput(
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      applicationType: map['applicationType'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginInput.fromJson(String source) =>
      LoginInput.fromMap(json.decode(source));

  @override
  String toString() =>
      'LoginInput(email: $email, password: $password, applicationType: $applicationType)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoginInput &&
        other.email == email &&
        other.password == password &&
        other.applicationType == applicationType;
  }

  @override
  int get hashCode =>
      email.hashCode ^ password.hashCode ^ applicationType.hashCode;
}
