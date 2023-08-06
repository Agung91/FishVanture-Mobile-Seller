import 'package:seller/common/image_picker/model_upload_image.dart';

abstract class UploadImageservice {
  Future<ImageModel> sendImage(
      {required String path, Function(int, int)? progress});
}
