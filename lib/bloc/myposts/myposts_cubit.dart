import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repo/user_repository.dart';

class MyPostsCubit extends Cubit<List<Map<String, dynamic>>> {
  final UserRepository userRepository;

  MyPostsCubit(this.userRepository) : super([]);

  Future<void> loadMyPosts() async {
    try {
      final images = await userRepository.getUserUploadedImages();
      emit(images);
    } catch (e) {
      emit([]);
    }
  }

  Future<void> deletePost(String imageId) async {
    try {
      await userRepository.deleteImage(imageId);
      await loadMyPosts(); // refresh
    } catch (e) {
      print("Error deleting post: $e");
    }
  }
}

