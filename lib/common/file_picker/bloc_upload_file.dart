import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:seller/common/file_picker/model_upload_file.dart';
import 'package:seller/common/file_picker/repo_upload_file.dart';

class UploadFileBloc {
  UploadFileBloc(this._repo);

  final UploadFileHttpRepo _repo;

  Future<FileModel> pickFile() async {
    final permission = await Permission.mediaLibrary.request();
    if (permission.isDenied) throw 'e';
    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        PlatformFile file = result.files.first;

        final FileModel response = await _repo.sendFile(path: file.path ?? '');
        print(response.file);
        print(response.name);
        return response;
      }
      throw 'Error meesage = Error select file';
    } catch (e) {
      rethrow;
    }
  }
}
