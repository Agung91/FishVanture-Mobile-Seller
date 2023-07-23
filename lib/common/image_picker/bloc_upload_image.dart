// import 'package:seller/common/image_compressor/image.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:sstream/sstream.dart';

// import 'event.dart';
// import 'state.dart';

// class ImageUploaderBloc {
//   ImageUploaderBloc(this.onChange);

//   final Function(String) onChange;

//   final picker = ImagePicker();

//   final _stream = SStream<ImageUploaderState>(ImageUploaderInitial());
//   Stream<ImageUploaderState> get stream => _stream.stream;
//   ImageUploaderState get value => _stream.value;

//   add(ImageUploaderEvent event) async {
//     if (event is SelectSource) {
//       final file = await picker.pickImage(
//         source: event.source,
//         // maxHeight: imageMaxHeight,
//         // maxWidth: imageMaxWidth,
//       );

//       if (file != null) {
//         try {
//           final compress = Compress.newIntance();
//           final path = await compress.compressFilePath(file.path);
//           _stream.add(ImageUploaderUploading(localPath: path));
//           final result = await repo.upload(path: path);
//           _stream.add(ImageUploaderSuccess(
//             filename: result.link,
//             local: path,
//             url: result.link,
//           ));
//           onChange(result.link);
//         } catch (e) {
//           if (e is Exception) _stream.add(ImageUploaderError(e: e));
//         }
//       } else {
//         _stream.add(ImageUploaderCanceled());
//       }
//     } else if (event is CancelUpload) {
//       repo.cancel();
//     }
//   }

//   delete() async {
//     try {
//       final result = await repo.upload(path: '');
//       _stream.add(ImageUploaderSuccess(
//         filename: result.link,
//         local: '',
//         url: result.link,
//       ));
//       onChange(result.link);
//     } catch (e) {
//       if (e is Exception) _stream.add(ImageUploaderError(e: e));
//     }
//   }
// }
