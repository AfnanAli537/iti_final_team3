import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iti_final_team3/bloc/form_bloc/form_bloc.dart';
import 'package:iti_final_team3/bloc/favourite_bloc/favourite_bloc.dart';
import 'package:iti_final_team3/bloc/home_bloc/image_bloc.dart';
import 'package:iti_final_team3/bloc/login_bloc/login_bloc.dart';
import 'package:iti_final_team3/bloc/nav_bloc/nav_bloc.dart';
import 'package:iti_final_team3/bloc/search_bloc/search_bloc.dart';
import 'package:iti_final_team3/bloc/signup_bloc/signup_bloc.dart';
import 'package:iti_final_team3/bloc/splash_bloc/splash_bloc.dart';
import 'package:iti_final_team3/bloc/theme_bloc/theme_bloc.dart';
import 'package:iti_final_team3/bloc/theme_bloc/theme_state.dart';
import 'package:iti_final_team3/bloc/upload_data/upload_bloc.dart';
import 'package:iti_final_team3/data/models/auth_repo.dart';
import 'package:iti_final_team3/data/repo/favourite_repo.dart';
import 'package:iti_final_team3/data/repo/image_repo.dart';
import 'package:iti_final_team3/screens/favourite_list_screen.dart';
import 'package:iti_final_team3/screens/forget_password_screen.dart';
import 'package:iti_final_team3/screens/home_screen.dart';
import 'package:iti_final_team3/screens/login_screen.dart';
import 'package:iti_final_team3/screens/main_navigation.dart';
import 'package:iti_final_team3/screens/profile_screen.dart';
import 'package:iti_final_team3/screens/signup_screen.dart';
import 'package:iti_final_team3/screens/splash_screen.dart';
import 'package:iti_final_team3/utils/app_themes.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authRepo = AuthRepo();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ImageBloc(ImageRepository())..add(LoadImages()),
        ),
        BlocProvider(create: (_) => SplashBloc()),
        BlocProvider(create: (_) => SignUpBloc(authRepo)),
        BlocProvider(create: (_) => LoginBloc(authRepo)),
        BlocProvider(create: (_) => ThemeBloc()),
        BlocProvider(
          create: (_) => UploadBloc(repository: ImageRepository()),
        ),
        BlocProvider(
          create: (_) => NavigationBloc(),
        ),
        BlocProvider(
          create: (_) => PasswordVisibilityBloc(),
        ),
        BlocProvider(
          create: (_) => FavouriteBloc(
            FavoriteRepository(),
            FirebaseAuth.instance,
          ),
        ),
        BlocProvider(
          create: (_) => SearchBloc(
            ImageRepository(),
          ),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp(
            title: 'inspiration App',
            themeMode: themeState.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            theme: AppThemes.lightTheme,
            darkTheme: AppThemes.darkTheme,
            debugShowCheckedModeBanner: false,
            routes: {
              '/main': (context) => MainNavigation(),
              '/login': (context) => const LoginPage(),
              '/signup': (context) => const SignUpPage(),
              '/profile': (context) => const ProfilePage(),
              '/home': (context) => const HomePage(),
              '/favourites': (context) => const FavouritePage(),
              '/forgetPassword': (context) => const ForgetPasswordScreen(),
            },
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
