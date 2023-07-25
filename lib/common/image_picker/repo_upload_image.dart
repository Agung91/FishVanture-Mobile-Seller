import 'package:dio/dio.dart';
import 'package:seller/common/http/http.dart';
import 'package:seller/common/image_picker/model_image.dart';
import 'package:seller/common/image_picker/service_image_service.dart';
import 'package:seller/config/hosts.dart';

class UploadImageHttpRepo extends HttpService implements UploadImageservice {
  @override
  Future<ImageModel> uploadImage({
    required String path,
    Function(int p1, int p2)? progress,
    String? url,
  }) async {
    FormData data = FormData.fromMap(
      {
        "image": await MultipartFile.fromFile(path),
      },
    );
    try {
      final response = await postImage(
        '/$host/upload-pool-photo',
        body: data,
      );
      return ImageModel.fromMap(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
