import 'dart:convert';

class CreateBudidayaInput {
  final String poolID;
  final DateTime dateOfSeed;
  final String fishSpeciesID;
  CreateBudidayaInput({
    required this.poolID,
    required this.dateOfSeed,
    required this.fishSpeciesID,
  });

  CreateBudidayaInput copyWith({
    String? poolID,
    DateTime? dateOfSeed,
    String? fishSpeciesID,
  }) {
    return CreateBudidayaInput(
      poolID: poolID ?? this.poolID,
      dateOfSeed: dateOfSeed ?? this.dateOfSeed,
      fishSpeciesID: fishSpeciesID ?? this.fishSpeciesID,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'poolID': poolID,
      'dateOfSeed': dateOfSeed.toUtc().toIso8601String(),
      'fishSpeciesID': fishSpeciesID,
    };
  }

  factory CreateBudidayaInput.fromMap(Map<String, dynamic> map) {
    return CreateBudidayaInput(
      poolID: map['poolID'] ?? '',
      dateOfSeed: DateTime.parse(map['dateOfSeed']),
      fishSpeciesID: map['fishSpeciesID'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateBudidayaInput.fromJson(String source) =>
      CreateBudidayaInput.fromMap(json.decode(source));

  @override
  String toString() =>
      'CreateBudidayaInput(poolID: $poolID, dateOfSeed: $dateOfSeed, fishSpeciesID: $fishSpeciesID)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CreateBudidayaInput &&
        other.poolID == poolID &&
        other.dateOfSeed == dateOfSeed &&
        other.fishSpeciesID == fishSpeciesID;
  }

  @override
  int get hashCode =>
      poolID.hashCode ^ dateOfSeed.hashCode ^ fishSpeciesID.hashCode;
}
