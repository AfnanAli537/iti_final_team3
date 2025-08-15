import 'package:flutter_bloc/flutter_bloc.dart';
import 'like_event.dart';
import 'like_state.dart';

class LikeBloc extends Bloc<LikeEvent, LikeState> {
  LikeBloc({bool initialIsLiked = false})
      : super(LikeState(isLiked: initialIsLiked)) {
    on<ToggleLikeEvent>((event, emit) {
      emit(state.copyWith(isLiked: !state.isLiked));
    });
  }
}