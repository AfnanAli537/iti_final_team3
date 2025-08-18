
part of 'upload_bloc.dart';

abstract class UploadState {
  final String title;
  final String description;
  final File? pickedImage;

  const UploadState({
    this.title = '',
    this.description = '',
    this.pickedImage,
  });
}

class UploadInitial extends UploadState {
  const UploadInitial() : super();
}

class UploadChanged extends UploadState {
  const UploadChanged({
    required super.title,
    required super.description,
    super.pickedImage,
  });
}

class UploadSubmitting extends UploadState {
  const UploadSubmitting({
    required super.title,
    required super.description,
    super.pickedImage,
  });
}

class UploadSuccess extends UploadState {
  const UploadSuccess() : super();
}

class UploadFailure extends UploadState {
  final String errorMessage;
  const UploadFailure(this.errorMessage);
}
