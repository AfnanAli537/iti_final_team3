import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iti_final_team3/utils/app_strings.dart';
import '../../data/repo/image_repo.dart';

part 'upload_event.dart';
part 'upload_state.dart';

class UploadBloc extends Bloc<UploadEvent, UploadState> {
  final ImageRepository repository;

  UploadBloc({required this.repository}) : super(const UploadInitial()) {
    on<ImagePicked>(_onImagePicked);
    on<TitleChanged>(_onTitleChanged);
    on<DescriptionChanged>(_onDescriptionChanged);
    on<ClearFormEvent>(_onClearFormEvent);
    on<UploadSubmitted>(_onUploadSubmitted);
  }

  void _onImagePicked(ImagePicked event, Emitter<UploadState> emit) {
    emit(UploadChanged(
      title: state.title,
      description: state.description,
      pickedImage: event.file,
    ));
  }

  void _onTitleChanged(event, emit) {
    emit(UploadChanged(
      title: event.title,
      description: state.description,
      pickedImage: state.pickedImage,
    ));
  }

  void _onDescriptionChanged(event, emit) {
    emit(UploadChanged(
      title: state.title,
      description: event.description,
      pickedImage: state.pickedImage,
    ));
  }

  void _onClearFormEvent(event, emit) {
    emit(const UploadInitial());
  }

  Future<void> _onUploadSubmitted(event, emit) async {
    if (state.pickedImage == null ||
        state.title.isEmpty ||
        state.description.isEmpty) {
      emit(const UploadFailure(AppStrings.errorMessage));
    }

    emit(UploadSubmitting(
      title: state.title,
      description: state.description,
      pickedImage: state.pickedImage,
    ));

    try {
      final imageUrl = await repository.uploadImage(state.pickedImage!);
      await repository.saveImageData(imageUrl, state.title, state.description);
      emit(const UploadSuccess());
    } catch (e) {
      emit(UploadFailure(e.toString()));
    }
  }
}
