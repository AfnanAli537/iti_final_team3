import 'package:equatable/equatable.dart';
import 'package:iti_final_team3/data/repo/image_model.dart';

abstract class LikeState extends Equatable {
  const LikeState();

  @override
  List<Object?> get props => [];
}

class LikeInitial extends LikeState {}

class LikeLoading extends LikeState {}

class LikeLoaded extends LikeState {
  final List<ImageModel> likes;
  const LikeLoaded(this.likes);

  @override
  List<Object?> get props => [likes];
}

class LikeError extends LikeState {
  final String message;
  const LikeError(this.message);

  @override
  List<Object?> get props => [message];
}