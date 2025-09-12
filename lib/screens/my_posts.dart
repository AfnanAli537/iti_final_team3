import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iti_final_team3/bloc/myposts/myposts_cubit.dart';
import 'package:iti_final_team3/bloc/upload_data/upload_bloc.dart';
import 'package:iti_final_team3/screens/upload_screen.dart';
import 'package:iti_final_team3/screens/details_screen.dart';
import 'package:iti_final_team3/data/repo/image_model.dart'; 

class MyPostsPage extends StatelessWidget {
  const MyPostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Posts")),
      body: BlocBuilder<MyPostsCubit, List<Map<String, dynamic>>>(
        builder: (context, posts) {
          if (posts.isEmpty) {
            return const Center(child: Text("No posts yet"));
          }
          return GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 0.7,
            ),
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              final imageId = post['id'] ?? "";

              return GestureDetector(
                onTap: () {
                 
                  final imageModel = ImageModel(
                    id: imageId,
                    url: post['url'] ?? '',
                    title: post['title'] ?? '',
                    description: post['description'] ?? '',
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailsPage(
                        image: imageModel,
                        images: posts.map((p) => p['url']).toList(),
                      ),
                    ),
                  );
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      Expanded(
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(
                              post['url'],
                              fit: BoxFit.cover,
                            ),
                            
                            Positioned(
                              top: 4,
                              right: 4,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit,
                                        color: Colors.blue),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => BlocProvider.value(
                                            value: context.read<UploadBloc>(),
                                            child: UploadPage(post: post),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (ctx) => AlertDialog(
                                          title: const Text("Delete Post"),
                                          content: const Text(
                                              "Are you sure you want to delete this post?"),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(ctx),
                                              child: const Text("Cancel"),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                context
                                                    .read<MyPostsCubit>()
                                                    .deletePost(imageId);
                                                Navigator.pop(ctx);
                                              },
                                              child: const Text("Delete"),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // ✅ العنوان
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 4),
                        child: Text(
                          post['title'] ?? '',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                     
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Text(
                          post['description'] ?? '',
                          style: const TextStyle(
                              fontSize: 12, color: Colors.grey),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 6),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}



