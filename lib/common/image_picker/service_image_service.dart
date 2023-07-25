import 'package:seller/common/image_picker/model_image.dart';

abstract class UploadImageservice {
  Future<ImageModel> uploadImage(
      {required String path, Function(int, int)? progress});
}
