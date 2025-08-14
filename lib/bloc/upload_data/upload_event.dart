part of 'upload_bloc.dart';

abstract class UploadEvent {}

class TitleChanged extends UploadEvent {
  final String title;
  TitleChanged(this.title);
}

class DescriptionChanged extends UploadEvent {
  final String description;
  DescriptionChanged(this.description);
}

class ImagePicked extends UploadEvent {
  final File file;
  ImagePicked(this.file);
}

class ClearFormEvent extends UploadEvent {}

class UploadSubmitted extends UploadEvent {}
