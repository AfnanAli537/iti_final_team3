import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iti_final_team3/utils/app_strings.dart';
import '../../data/repo/image_repo.dart';
import '../../data/repo/user_repository.dart';

part 'upload_event.dart';
part 'upload_state.dart';

class UploadBloc extends Bloc<UploadEvent, UploadState> {
  final ImageRepository imageRepository;
  final UserRepository userRepository;

  UploadBloc({
    required this.imageRepository,
    required this.userRepository,
  }) : super(const UploadInitial()) {
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
      return emit(const UploadFailure(AppStrings.errorMessage));
    }

    emit(UploadSubmitting(
      title: state.title,
      description: state.description,
      pickedImage: state.pickedImage,
    ));

    try {
      final imageUrl = await imageRepository.uploadImage(state.pickedImage!);
      final imageId = await imageRepository.saveImageData(imageUrl, state.title, state.description,);

      await userRepository.addImageToUser(imageId);

      emit(const UploadSuccess());
    } catch (e) {
      emit(UploadFailure(e.toString()));
    }
  }
}
