import 'package:image_picker/image_picker.dart';
import 'package:seller/common/image_picker/repo_upload_image.dart';

class ImageUploaderBloc {
  ImageUploaderBloc(this._repo);

  final UploadImageHttpRepo _repo;
  final picker = ImagePicker();

  upload(ImageSource imageSource) async {
//  pick image
    final file = await picker.pickImage(
      source: imageSource,
    );

// compress image
    if (file != null) {
      final result = _repo.postImage(file.path);
      print(result);
    }
  }
}
