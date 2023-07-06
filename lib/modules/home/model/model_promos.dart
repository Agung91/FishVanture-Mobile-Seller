import 'dart:convert';

class PromosModel {
  final String id;
  final String title;
  final String description;
  final String startDate;
  final String endDate;
  final String imagesName;
  PromosModel({
    required this.id,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.imagesName,
    required this.imagesLink,
  });

  PromosModel copyWith({
    String? id,
    String? tittle,
    String? description,
    String? startDate,
    String? endDate,
    String? imagesName,
    String? imagesLink,
  }) {
    return PromosModel(
      id: id ?? this.id,
      title: tittle ?? this.title,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      imagesName: imagesName ?? this.imagesName,
      imagesLink: imagesLink ?? this.imagesLink,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tittle': title,
      'description': description,
      'startDate': startDate,
      'endDate': endDate,
      'imagesName': imagesName,
      'imagesLink': imagesLink,
    };
  }

  factory PromosModel.fromMap(Map<String, dynamic> map) {
    return PromosModel(
      id: map['id'] ?? '',
      title: map['tittle'] ?? '',
      description: map['description'] ?? '',
      startDate: map['startDate'] ?? '',
      endDate: map['endDate'] ?? '',
      imagesName: map['imagesName'] ?? '',
      imagesLink: map['imagesLink'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PromosModel.fromJson(String source) =>
      PromosModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PromosModel(id: $id, tittle: $title, description: $description, startDate: $startDate, endDate: $endDate, imagesName: $imagesName, imagesLink: $imagesLink)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PromosModel &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.startDate == startDate &&
        other.endDate == endDate &&
        other.imagesName == imagesName &&
        other.imagesLink == imagesLink;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        startDate.hashCode ^
        endDate.hashCode ^
        imagesName.hashCode ^
        imagesLink.hashCode;
  }

  final String imagesLink;
}
