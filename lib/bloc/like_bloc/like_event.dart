import 'package:equatable/equatable.dart';
import 'package:iti_final_team3/data/repo/image_model.dart';

abstract class LikeEvent extends Equatable {
  const LikeEvent();

  @override
  List<Object?> get props => [];
}


class ToggleLike extends LikeEvent {
  final ImageModel image;
  const ToggleLike(this.image);

  @override
  List<Object?> get props => [image];
}


class LoadLikes extends LikeEvent {
  const LoadLikes();
}
