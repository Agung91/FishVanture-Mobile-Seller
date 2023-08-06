abstract class ImageUploaderState {}

class ImageUploaderInitial extends ImageUploaderState {}

class ImageUploaderUploading extends ImageUploaderState {
  String localPath;
  ImageUploaderUploading({
    required this.localPath,
  });
}

class ImageUploaderSuccess extends ImageUploaderState {
  final String filename;
  final String local;
  final String url;
  ImageUploaderSuccess({
    required this.filename,
    required this.local,
    required this.url,
  });
}

class ImageUploaderCanceled extends ImageUploaderState {}

class ImageUploaderError extends ImageUploaderState {
  Exception e;
  ImageUploaderError({
    required this.e,
  });
}
