part of 'upload_bloc.dart';

class UploadState {
  final File? pickedImage;
  final String title;
  final String description;
  final bool isSubmitting;
  final bool isSuccess;
  final String errorMessage;

  UploadState({
    this.pickedImage,
    this.title = '',
    this.description = '',
    this.isSubmitting = false,
    this.isSuccess = false,
    this.errorMessage = '',
  });

  UploadState copyWith({
    File? pickedImage,
    String? title,
    String? description,
    bool? isSubmitting,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return UploadState(
      pickedImage: pickedImage ?? this.pickedImage,
      title: title ?? this.title,
      description: description ?? this.description,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
