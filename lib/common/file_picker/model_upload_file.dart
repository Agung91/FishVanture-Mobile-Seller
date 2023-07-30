import 'dart:convert';

class UploadFileModel {
  final String name;
  final String file;
  UploadFileModel({
    required this.name,
    required this.file,
  });

  UploadFileModel copyWith({
    String? name,
    String? file,
  }) {
    return UploadFileModel(
      name: name ?? this.name,
      file: file ?? this.file,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'file': file,
    };
  }

  factory UploadFileModel.fromMap(Map<String, dynamic> map) {
    return UploadFileModel(
      name: map['name'] ?? '',
      file: map['file'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UploadFileModel.fromJson(String source) => UploadFileModel.fromMap(json.decode(source));

  @override
  String toString() => 'UploadFileModel(name: $name, file: $file)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UploadFileModel &&
      other.name == name &&
      other.file == file;
  }

  @override
  int get hashCode => name.hashCode ^ file.hashCode;
}
