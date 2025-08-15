import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iti_final_team3/bloc/nav_bloc/nav_bloc.dart';
import 'package:iti_final_team3/screens/home_screen.dart';
import 'package:iti_final_team3/screens/profile_screen.dart';
import 'package:iti_final_team3/screens/favourite_list_screen.dart';
import 'package:iti_final_team3/screens/upload_screen.dart';
import 'package:iti_final_team3/utils/app_strings.dart';

class MainNavigation extends StatelessWidget {
  final List<Widget> pages = const [
    HomePage(),
    UploadPage(),
    FavouritePage(),
    ProfilePage(),
  ];

  const MainNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return Scaffold(
          body: pages[state.currentPage],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: state.currentPage,
            onTap: (index) {
              context.read<NavigationBloc>().add(NavigateTo(index));
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: AppStrings.home),
              BottomNavigationBarItem(
                  icon: Icon(Icons.add_photo_alternate_rounded),
                  label: AppStrings.upload),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: AppStrings.favourite),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: AppStrings.profile),
            ],
          ),
        );
      },
    );
  }
}
