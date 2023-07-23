import 'package:seller/common/image_picker/model_image.dart';
import 'package:seller/modules/submission/model/model_file.dart';
import 'package:seller/modules/submission/model/model_submission.dart';

abstract class SubmissionService {
  Future<String?> createPond(SubmissionModel input);
  Future<ImageModel> uploadPoolPhoto(
      {required String path, Function(int, int)? progress});
}
