import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iti_final_team3/bloc/favourite_bloc/favourite_bloc.dart';
import 'package:iti_final_team3/bloc/favourite_bloc/favourite_event.dart';
import 'package:iti_final_team3/bloc/favourite_bloc/favourite_state.dart';
import 'package:iti_final_team3/screens/details_screen.dart';
import 'package:iti_final_team3/screens/heart_icon.dart'; // LikeButton

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<FavouriteBloc>().add(LoadFavourites());

    return Scaffold(
      appBar: AppBar(title: const Text("My Favourites")),
      body: BlocBuilder<FavouriteBloc, FavouriteState>(
        builder: (context, state) {
          if (state is FavouriteLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FavouriteLoaded) {
            if (state.favourites.isEmpty) {
              return const Center(child: Text("No favourites yet"));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: state.favourites.length,
              itemBuilder: (context, index) {
                final img = state.favourites[index];
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
          } else if (state is FavouriteError) {
            return Center(child: Text(state.error));
          }
          return const SizedBox();
        },
      ),
    );
  }
}
