import 'dart:convert';

class CompleteOrderInput {
  final String id;
  CompleteOrderInput({
    required this.id,
  });

  CompleteOrderInput copyWith({
    String? id,
  }) {
    return CompleteOrderInput(
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
    };
  }

  factory CompleteOrderInput.fromMap(Map<String, dynamic> map) {
    return CompleteOrderInput(
      id: map['id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CompleteOrderInput.fromJson(String source) =>
      CompleteOrderInput.fromMap(json.decode(source));

  @override
  String toString() => 'CancelOrderInput(id: $id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CompleteOrderInput && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
