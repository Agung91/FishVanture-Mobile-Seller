import 'dart:convert';

class PoolModel {
  final String name;
  final double long;
  final double wide;
  final String image;
  PoolModel({
    required this.name,
    required this.long,
    required this.wide,
    required this.image,
  });

  PoolModel copyWith({
    String? name,
    double? long,
    double? wide,
    String? image,
  }) {
    return PoolModel(
      name: name ?? this.name,
      long: long ?? this.long,
      wide: wide ?? this.wide,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'long': long,
      'wide': wide,
      'image': image,
    };
  }

  factory PoolModel.fromMap(Map<String, dynamic> map) {
    return PoolModel(
      name: map['name'] ?? '',
      long: map['long']?.toDouble() ?? 0.0,
      wide: map['wide']?.toDouble() ?? 0.0,
      image: map['image'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PoolModel.fromJson(String source) =>
      PoolModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PoolModel(name: $name, long: $long, wide: $wide, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PoolModel &&
        other.name == name &&
        other.long == long &&
        other.wide == wide &&
        other.image == image;
  }

  @override
  int get hashCode {
    return name.hashCode ^ long.hashCode ^ wide.hashCode ^ image.hashCode;
  }
}
