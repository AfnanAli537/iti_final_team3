class LikeState {
  final bool isLiked;

  LikeState({required this.isLiked});

  LikeState copyWith({bool? isLiked}) {
    return LikeState(
      isLiked: isLiked ?? this.isLiked,
    );
  }
}
