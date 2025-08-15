// bloc/favourite_bloc/favourite_event.dart
import 'package:equatable/equatable.dart';
import 'package:iti_final_team3/data/repo/image_model.dart';

abstract class FavouriteEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadFavourites extends FavouriteEvent {
  
}

class AddFavourite extends FavouriteEvent {
  final ImageModel image;
  AddFavourite(this.image);

  @override
  List<Object?> get props => [image];
}

class RemoveFavourite extends FavouriteEvent {
  final String imageUrl;
  RemoveFavourite(this.imageUrl);

  @override
  List<Object?> get props => [imageUrl];
}
