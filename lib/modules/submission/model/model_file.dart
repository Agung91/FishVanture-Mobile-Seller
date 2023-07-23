import 'dart:convert';

class FileModel {
  final String name;
  final String file;
  FileModel({
    required this.name,
    required this.file,
  });

  FileModel copyWith({
    String? name,
    String? file,
  }) {
    return FileModel(
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

  factory FileModel.fromMap(Map<String, dynamic> map) {
    return FileModel(
      name: map['name'] ?? '',
      file: map['file'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory FileModel.fromJson(String source) =>
      FileModel.fromMap(json.decode(source));

  @override
  String toString() => 'FileModel(name: $name, file: $file)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FileModel && other.name == name && other.file == file;
  }

  @override
  int get hashCode => name.hashCode ^ file.hashCode;
}
