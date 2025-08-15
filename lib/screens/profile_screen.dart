import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:iti_final_team3/bloc/login_bloc/login_bloc.dart';
import 'package:iti_final_team3/bloc/theme_bloc/theme_bloc.dart';
import 'package:iti_final_team3/bloc/theme_bloc/theme_event.dart';
import 'package:iti_final_team3/screens/login_screen.dart';
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
          appBar: AppBar(title: const Text("Profile")),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),

                  // صورة البروفايل
                  Center(
                    child: ProfileAvatar(
                      backgroundColor: colorScheme.surface,
                      iconColor: colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // الاسم
                  ProfileInfoRow(
                    icon: Icons.person,
                    label: "Name",
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

                  // الإيميل
                  ProfileInfoRow(
                    icon: Icons.email,
                    label: "Email",
                    value: currentUser?.email ?? 'No Email',
                    iconColor: colorScheme.primary,
                    labelStyle: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    valueStyle: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.secondary,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // تغيير المود
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.brightness_6,
                            color: colorScheme.primary,
                            size: 30,
                          ),
                          const SizedBox(width: 10),
                          Text('Dark Mode', style: textTheme.titleLarge),
                        ],
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

                  // تسجيل الخروج
                  InkWell(
                    onTap: () {
                      context.read<LoginBloc>().add(LogoutEvent());
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Row(
                      children: [
                        const Icon(Icons.logout, color: Colors.red, size: 28),
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

                  const SizedBox(height: 50), // مساحة إضافية تحت
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
