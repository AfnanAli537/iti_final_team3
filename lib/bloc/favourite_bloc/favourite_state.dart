import 'package:equatable/equatable.dart';
import 'package:iti_final_team3/data/repo/image_model.dart';

abstract class FavouriteState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FavouriteLoading extends FavouriteState {}

class FavouriteLoaded extends FavouriteState {
  final List<ImageModel> favourites;
  FavouriteLoaded(this.favourites);

  @override
  List<Object?> get props => [favourites];
}

class FavouriteError extends FavouriteState {
  final String error;
  FavouriteError(this.error);

  @override
  List<Object?> get props => [error];
}