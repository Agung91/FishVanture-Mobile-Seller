import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:seller/common/file_picker/model_upload_file.dart';
import 'package:seller/common/file_picker/repo_upload_file.dart';
import 'package:sstream/sstream.dart';

class UploadFileBloc {
  UploadFileBloc(this._repo);

  final UploadFileHttpRepo _repo;
  final uploadProgress = 0.0.stream;
  final name = 'Upload'.stream;

  Future<FileModel> pickFile() async {
    final permission = await Permission.mediaLibrary.request();
    if (permission.isDenied) throw 'e';
    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        PlatformFile file = result.files.first;

        final FileModel response = await _repo.sendFile(
          path: file.path ?? '',
          progress: (p1, p2) {
            final percen = p1 / p2;
            uploadProgress.add(percen);
          },
        );
        name.add('Success');
        uploadProgress.add(0.0);
        return response;
      }
      uploadProgress.add(0.0);
      throw 'Error meesage = Error select file';
    } catch (e) {
      uploadProgress.add(0.0);
      rethrow;
    }
  }
}
