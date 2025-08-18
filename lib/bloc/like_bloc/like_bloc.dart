import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:iti_final_team3/bloc/like_bloc/like_event.dart';
import 'package:iti_final_team3/bloc/like_bloc/like_state.dart';
import 'package:iti_final_team3/data/repo/favourite_repo.dart';
import 'package:iti_final_team3/data/repo/image_model.dart';

class LikeBloc extends Bloc<LikeEvent, LikeState> {
  final FavoriteRepository repo;
  final FirebaseAuth auth;

  LikeBloc(this.repo, this.auth) : super(LikeInitial()) {
    on<LoadLikes>(_onLoadLikes);
    on<ToggleLike>(_onToggleLike);
  }

  Future<void> _onLoadLikes(
      LoadLikes event, Emitter<LikeState> emit) async {
    final userId = auth.currentUser?.uid;
    if (userId == null) {
      emit(const LikeError("User not logged in"));
      return;
    }

    emit(LikeLoading());
    try {
      await emit.forEach<List<ImageModel>>(
        repo.fetchFavorites(userId),
        onData: (likes) => LikeLoaded(likes),
        onError: (_, __) => const LikeError("Failed to load likes"),
      );
    } catch (e) {
      emit(LikeError(e.toString()));
    }
  }

  Future<void> _onToggleLike(
      ToggleLike event, Emitter<LikeState> emit) async {
    final userId = auth.currentUser?.uid;
    if (userId == null) {
      emit(const LikeError("User not logged in"));
      return;
    }

    try {
      if (state is LikeLoaded) {
        final currentLikes = List<ImageModel>.from((state as LikeLoaded).likes);
        final exists = currentLikes.any((fav) => fav.url == event.image.url);

        if (exists) {
          await repo.removeFromFavorites(userId, event.image.url);
          currentLikes.removeWhere((fav) => fav.url == event.image.url);
        } else {
          await repo.addToFavorites(userId, event.image);
          currentLikes.add(event.image);
        }

        emit(LikeLoaded(currentLikes));
      } else {
        // أول مرة بيتعمل like
        await repo.addToFavorites(userId, event.image);
        emit(LikeLoaded([event.image]));
      }
    } catch (e) {
      emit(LikeError("Failed to toggle like: ${e.toString()}"));
    }
  }
}