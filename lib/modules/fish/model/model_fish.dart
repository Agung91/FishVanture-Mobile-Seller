import 'dart:convert';

class FishModel {
  final String name;
  final String asal;
  FishModel({
    required this.name,
    required this.asal,
  });

  FishModel copyWith({
    String? name,
    String? asal,
  }) {
    return FishModel(
      name: name ?? this.name,
      asal: asal ?? this.asal,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'asal': asal,
    };
  }

  factory FishModel.fromMap(Map<String, dynamic> map) {
    return FishModel(
      name: map['name'] ?? '',
      asal: map['asal'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory FishModel.fromJson(String source) =>
      FishModel.fromMap(json.decode(source));

  @override
  String toString() => 'FishModel(name: $name, asal: $asal)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FishModel && other.name == name && other.asal == asal;
  }

  @override
  int get hashCode => name.hashCode ^ asal.hashCode;
}
