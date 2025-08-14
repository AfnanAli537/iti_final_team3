import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iti_final_team3/utils/app_strings.dart';
import '../../data/repo/image_repo.dart';
part 'upload_event.dart';
part 'upload_state.dart';

class UploadBloc extends Bloc<UploadEvent, UploadState> {
  final ImageRepository repository;

  UploadBloc({required this.repository}) : super(UploadState()) {
    on<ImagePicked>((event, emit) {
      emit(
        state.copyWith(
            pickedImage: event.file, errorMessage: '', isSuccess: false),
      );
    });

    on<TitleChanged>((event, emit) {
      emit(state.copyWith(title: event.title));
    });

    on<DescriptionChanged>((event, emit) {
      emit(state.copyWith(description: event.description));
    });

    on<ClearFormEvent>((event, emit) {
      emit(UploadState());
    });

    on<UploadSubmitted>((event, emit) async {
      if (state.pickedImage == null ||
          state.title.isEmpty ||
          state.description.isEmpty) {
        emit(state.copyWith(errorMessage: AppStrings.errorMessage));
        return;
      }
      emit(state.copyWith(
          isSubmitting: true, errorMessage: '', isSuccess: false));
      try {
        final imageUrl = await repository.uploadImage(state.pickedImage!);
        await repository.saveImageData(
            imageUrl, state.title, state.description);

        emit(state.copyWith(isSubmitting: false, isSuccess: true));
      } catch (e) {
        emit(state.copyWith(isSubmitting: false, errorMessage: e.toString()));
      }
    });
  }
}
