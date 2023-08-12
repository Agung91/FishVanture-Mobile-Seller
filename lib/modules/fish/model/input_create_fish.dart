import 'dart:convert';

class CreateFishInput {
  final String name;
  final String asal;
  CreateFishInput({
    required this.name,
    required this.asal,
  });

  CreateFishInput copyWith({
    String? name,
    String? asal,
  }) {
    return CreateFishInput(
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

  factory CreateFishInput.fromMap(Map<String, dynamic> map) {
    return CreateFishInput(
      name: map['name'] ?? '',
      asal: map['asal'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateFishInput.fromJson(String source) =>
      CreateFishInput.fromMap(json.decode(source));

  @override
  String toString() => 'CreateFishInput(name: $name, asal: $asal)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CreateFishInput && other.name == name && other.asal == asal;
  }

  @override
  int get hashCode => name.hashCode ^ asal.hashCode;
}
