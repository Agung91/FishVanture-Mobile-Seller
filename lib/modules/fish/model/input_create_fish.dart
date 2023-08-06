import 'dart:convert';

class CreatePoolInput {
  final String name;
  final String asal;
  CreatePoolInput({
    required this.name,
    required this.asal,
  });

  CreatePoolInput copyWith({
    String? name,
    String? asal,
  }) {
    return CreatePoolInput(
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

  factory CreatePoolInput.fromMap(Map<String, dynamic> map) {
    return CreatePoolInput(
      name: map['name'] ?? '',
      asal: map['asal'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CreatePoolInput.fromJson(String source) =>
      CreatePoolInput.fromMap(json.decode(source));

  @override
  String toString() => 'CreatePoolInput(name: $name, asal: $asal)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CreatePoolInput && other.name == name && other.asal == asal;
  }

  @override
  int get hashCode => name.hashCode ^ asal.hashCode;
}
