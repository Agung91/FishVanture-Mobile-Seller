import 'package:dio/dio.dart';
import 'package:seller/common/http/http.dart';
import 'package:seller/common/image_picker/model_image.dart';
import 'package:seller/config/hosts.dart';
import 'package:seller/modules/submission/model/model_file.dart';
import 'package:seller/modules/submission/model/model_submission.dart';
import 'package:seller/modules/submission/model/service_submission.dart';

class SubmissionHttpRepo extends HttpService implements SubmissionService {
  @override
  Future<String?> createPond(SubmissionModel input) async {
    try {
      final response = await post(
        '/$host/create-pond',
        body: input.toMap(),
      );
      return response.id;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ImageModel> uploadPoolPhoto({
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
