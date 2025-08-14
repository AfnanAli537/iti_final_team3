import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iti_final_team3/data/repo/image_repo.dart';
import 'package:iti_final_team3/utils/app_strings.dart';

part 'image_event.dart';
part 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  final ImageRepository repository;

  ImageBloc(this.repository) : super(ImageInitial()) {
    on<LoadImages>(_onLoadImages);
  }
  Future<void> _onLoadImages(event, emit) async {
    emit(ImageLoading());
    try {
      await emit.forEach<List<String>>(
        repository.fetchImages(),
        onData: (images) {
          if (images.isEmpty) return ImageEmpty();
          return ImageLoaded(images);
        },
        onError: (_, __) => ImageError(AppStrings.failed),
      );
    } catch (e) {
      emit(ImageError(e.toString()));
    }
  }
}
