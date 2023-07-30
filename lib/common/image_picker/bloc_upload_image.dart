import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seller/common/image_picker/model_upload_image.dart';
import 'package:seller/common/image_picker/repo_upload_image.dart';
import 'package:seller/common/image_picker/state_upload_image.dart';
import 'package:sstream/sstream.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class ImageUploaderBloc {
  ImageUploaderBloc(this._repo);

  final UploadImageHttpRepo _repo;
  final _picker = ImagePicker();

  final _stream = SStream<ImageUploaderState>(ImageUploaderInitial());
  Stream<ImageUploaderState> get stream => _stream.stream;
  ImageUploaderState get value => _stream.value;

  
  Future<String> _compressFilePath(String path) async {
    final filename = basename(path);
    final temp = await path_provider.getTemporaryDirectory();
    final newPath = "${temp.absolute.path}/compresed_$filename";
    try {
      var result = await FlutterImageCompress.compressAndGetFile(
        path,
        newPath,
        quality: 50,
      );
      if (result == null) throw "failed to compress files";
      return newPath;
    } catch (error) {
      rethrow;
    }
  }
}
