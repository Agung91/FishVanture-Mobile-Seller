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
  String toString() => 'UploadFileModel(name: $name, file: $file)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FileModel && other.name == name && other.file == file;
  }

  @override
  int get hashCode => name.hashCode ^ file.hashCode;
}

class FileModelResponse {
  final String name;
  final String url;
  FileModelResponse({
    required this.name,
    required this.url,
  });

  FileModelResponse copyWith({
    String? name,
    String? url,
  }) {
    return FileModelResponse(
      name: name ?? this.name,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'url': url,
    };
  }

  factory FileModelResponse.fromMap(Map<String, dynamic> map) {
    return FileModelResponse(
      name: map['name'] ?? '',
      url: map['url'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory FileModelResponse.fromJson(String source) =>
      FileModelResponse.fromMap(json.decode(source));

  @override
  String toString() => 'FileModelResponse(name: $name, url: $url)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FileModelResponse && other.name == name && other.url == url;
  }

  @override
  int get hashCode => name.hashCode ^ url.hashCode;
}
