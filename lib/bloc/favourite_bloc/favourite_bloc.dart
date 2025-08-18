import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:iti_final_team3/bloc/favourite_bloc/favourite_event.dart';
import 'package:iti_final_team3/bloc/favourite_bloc/favourite_state.dart';
import 'package:iti_final_team3/data/repo/favourite_repo.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  final FavoriteRepository repo;
  final FirebaseAuth auth;

  FavouriteBloc(this.repo, this.auth) : super(FavouriteLoading()) {
    on<LoadFavourites>((event, emit) async {
      final userId = auth.currentUser?.uid;
      if (userId == null) {
        emit(FavouriteError("User not logged in"));
        return;
      }

      emit(FavouriteLoading());
      try {
        await emit.forEach(
          repo.fetchFavorites(userId),
          onData: (favs) => FavouriteLoaded(favs),
          onError: (_, __) => FavouriteError("Failed to load favourites"),
        );
      } catch (e) {
        emit(FavouriteError(e.toString()));
      }
    });

    on<AddFavourite>((event, emit) async {
      final userId = auth.currentUser?.uid;
      if (userId == null) {
        emit(FavouriteError("User not logged in"));
        return;
      }

      try {
        await repo.addToFavorites(userId, event.image);
      } catch (e) {
        emit(FavouriteError("Failed to add favourite: ${e.toString()}"));
      }
    });

    on<RemoveFavourite>((event, emit) async {
      final userId = auth.currentUser?.uid;
      if (userId == null) {
        emit(FavouriteError("User not logged in"));
        return;
      }

      try {
        await repo.removeFromFavorites(userId, event.imageUrl);
      } catch (e) {
        emit(FavouriteError("Failed to remove favourite: ${e.toString()}"));
      }
    });
  }
}