import 'package:dio/dio.dart';
import 'package:seller/common/file_picker/model_upload_file.dart';
import 'package:seller/common/file_picker/service_upload_file.dart';
import 'package:seller/common/http/http.dart';
import 'package:seller/config/hosts.dart';

class UploadFileHttpRepo extends HttpService implements UploadFileService {
  @override
  Future<FileModel> sendFile(
      {required String path, Function(int p1, int p2)? progress}) async {
    FormData data = FormData.fromMap(
      {
        "file": await MultipartFile.fromFile(path),
      },
    );
    try {
      final response = await postImage(
        '$uploadfile/upload-file',
        body: data,
        onSendProgress: progress,
      );
      final a = FileModelResponse.fromMap(response.data);
      return FileModel(name: data.files.first.value.filename ?? '', url: a.url);
    } catch (e) {
      rethrow;
    }
  }
}
