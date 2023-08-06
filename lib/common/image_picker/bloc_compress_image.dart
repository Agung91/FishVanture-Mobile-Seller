// import 'dart:io';

// import 'package:flutter_image_compress/flutter_image_compress.dart';
// import 'package:path/path.dart';

// import 'package:path_provider/path_provider.dart' as path_provider;

// abstract class Compress {
//   Future<File> compressFile(File file, String targetPath);
//   Future<String> compressFilePath(String input);
//   static final Compress _intence = _build();

//   static Compress _build() {
//     if (Platform.isAndroid || Platform.isIOS) {
//       return _CompressImpl();
//     }
//     throw "unimplemented";
//   }

// // Factory Method
//   static Compress newIntance() {
//     return _intence;
//   }
// }

// class _CompressImpl extends Compress {
//   @override
//   Future<File> compressFile(File file, String targetPath) async {
//     try {
//       var result = await FlutterImageCompress.compressAndGetFile(
//         file.absolute.path,
//         targetPath,
//         quality: 88,
//         rotate: 180,
//       );
//       if (result == null) throw "failed to compress files";
//       return result;
//     } catch (error) {
//       rethrow;
//     }
//   }

//   @override
//   Future<String> compressFilePath(String path) async {
//     final filename = basename(path);
//     final temp = await path_provider.getTemporaryDirectory();
//     final newPath = "${temp.absolute.path}/compresed_$filename";
//     try {
//       var result = await FlutterImageCompress.compressAndGetFile(
//         path,
//         newPath,
//         quality: 50,
//       );
//       if (result == null) throw "failed to compress files";
//       return newPath;
//     } catch (error) {
//       rethrow;
//     }
//   }
// }
