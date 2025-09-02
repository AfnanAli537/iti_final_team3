import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iti_final_team3/bloc/like_bloc/like_bloc.dart';
import 'package:iti_final_team3/bloc/like_bloc/like_state.dart';
import 'package:iti_final_team3/screens/details_screen.dart';
import 'package:iti_final_team3/screens/heart_icon.dart';
import 'package:lottie/lottie.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Favourites")),
      body: BlocBuilder<LikeBloc, LikeState>(
        builder: (context, state) {
          if (state is LikeLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LikeLoaded) {
            if (state.likes.isEmpty) {
              return Center(
                  child: Lottie.asset(
                'assets/lottie/Cute heart broken.json',
              ));
            }
            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: state.likes.length,
              itemBuilder: (context, index) {
                final img = state.likes[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailsPage(image: img),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey[200],
                    ),
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            img.url,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 180,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: LikeButton(image: img),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is LikeError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),
    );
  }
}
