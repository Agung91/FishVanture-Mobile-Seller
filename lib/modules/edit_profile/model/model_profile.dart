import 'dart:convert';

class ProfileModel {
  final String? name;
  final String? email;
  final String? phone;
  final String? photo;
  ProfileModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.photo,
  });

  ProfileModel copyWith({
    String? name,
    String? email,
    String? phone,
    String? photo,
  }) {
    return ProfileModel(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      photo: photo ?? this.photo,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'photo': photo,
    };
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      photo: map['photo'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileModel.fromJson(String source) =>
      ProfileModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Profile(name: $name, email: $email, phone: $phone, photo: $photo)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProfileModel &&
        other.name == name &&
        other.email == email &&
        other.phone == phone &&
        other.photo == photo;
  }

  @override
  int get hashCode {
    return name.hashCode ^ email.hashCode ^ phone.hashCode ^ photo.hashCode;
  }
}
