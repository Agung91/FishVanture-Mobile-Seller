import 'dart:convert';

class RegsiterInput {
  final String name;
  final String email;
  final String password;
  final String applicationType;
  RegsiterInput({
    required this.name,
    required this.email,
    required this.password,
    required this.applicationType,
  });

  RegsiterInput copyWith({
    String? name,
    String? email,
    String? password,
    String? applicationType,
  }) {
    return RegsiterInput(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      applicationType: applicationType ?? this.applicationType,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'applicationType': applicationType,
    };
  }

  factory RegsiterInput.fromMap(Map<String, dynamic> map) {
    return RegsiterInput(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      applicationType: map['applicationType'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RegsiterInput.fromJson(String source) =>
      RegsiterInput.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RegsiterInput(name: $name, email: $email, password: $password, applicationType: $applicationType)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RegsiterInput &&
        other.name == name &&
        other.email == email &&
        other.password == password &&
        other.applicationType == applicationType;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        password.hashCode ^
        applicationType.hashCode;
  }
}
