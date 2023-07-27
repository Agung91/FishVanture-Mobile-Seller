import 'package:image_picker/image_picker.dart';

abstract class ImageUploaderEvent {}

class SelectSource extends ImageUploaderEvent {
  final ImageSource source;

  SelectSource(this.source);
}

class CancelUpload extends ImageUploaderEvent {}
