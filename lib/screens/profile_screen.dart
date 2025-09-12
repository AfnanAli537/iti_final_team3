import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:iti_final_team3/bloc/login_bloc/login_bloc.dart';
import 'package:iti_final_team3/bloc/myposts/myposts_cubit.dart';
import 'package:iti_final_team3/bloc/theme_bloc/theme_bloc.dart';
import 'package:iti_final_team3/bloc/theme_bloc/theme_event.dart';
import 'package:iti_final_team3/data/repo/user_repository.dart';
import 'package:iti_final_team3/screens/login_screen.dart';
import 'package:iti_final_team3/screens/my_posts.dart';
import 'package:iti_final_team3/utils/app_strings.dart';
import 'package:iti_final_team3/widget/profileinfo.dart';
import 'package:iti_final_team3/widget/profilephoto.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    final currentUser = FirebaseAuth.instance.currentUser;

    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LogoutState) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        bool isDarkMode = theme.brightness == Brightness.dark;

        return Scaffold(
          appBar: AppBar(title: const Text('Profile')),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),

                  Center(
                    child: ProfileAvatar(
                      backgroundColor: colorScheme.surface,
                      iconColor: colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 40),

                  
                  ProfileInfoRow(
                    icon: Icons.person,
                    label: AppStrings.name,
                    value: currentUser?.displayName ?? 'No Name',
                    iconColor: colorScheme.primary,
                    labelStyle: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    valueStyle: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.secondary,
                    ),
                  ),
                  const SizedBox(height: 20),

                  
                  ProfileInfoRow(
                    icon: Icons.email,
                    label: AppStrings.email,
                    value: currentUser?.email ?? 'No Email',
                    iconColor: colorScheme.primary,
                    labelStyle: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    valueStyle: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.secondary,
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    child: Row(
                      children: [
                        Icon(
                          Icons.list_alt_sharp,
                          color: colorScheme.primary,
                          size: 30,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'My posts',
                          style: textTheme.titleLarge,
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider(
                            create: (_) =>
                                MyPostsCubit(UserRepository())..loadMyPosts(),
                            child: const MyPostsPage(),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ProfileInfoRow(
                          icon: Icons.brightness_6,
                          label: AppStrings.mode,
                          value: isDarkMode
                              ? AppStrings.darkmode
                              : AppStrings.lightmode,
                          iconColor: colorScheme.primary,
                          labelStyle: textTheme.titleLarge,
                          valueStyle: textTheme.bodyMedium?.copyWith(
                            color: colorScheme.secondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Switch(
                        value: isDarkMode,
                        onChanged: (_) {
                          context.read<ThemeBloc>().add(ToggleThemeEvent());
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),

                  InkWell(
                    onTap: () {
                      context.read<LoginBloc>().add(LogoutEvent());
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Row(
                      children: [
                        Icon(Icons.logout, color: Colors.red, size: 28),
                        const SizedBox(width: 10),
                        Text(
                          'Logout',
                          style: textTheme.titleLarge?.copyWith(
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
