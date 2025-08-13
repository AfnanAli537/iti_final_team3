import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iti_final_team3/bloc/login_bloc/login_bloc.dart';
import 'package:iti_final_team3/bloc/signup_bloc/signup_bloc.dart';
import 'package:iti_final_team3/bloc/splash_bloc/splash_bloc.dart';
import 'package:iti_final_team3/data/models/auth_repo.dart';
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
          create: (_) => SignUpBloc(authRepo),
        ),
        BlocProvider(
          create: (_) => LoginBloc(authRepo),
        ),
        BlocProvider(create: (_) => SplashBloc()),
      ],
      child: MaterialApp(
        title: 'inspiration App',
        themeMode: ThemeMode.light,
        theme: AppThemes.lightTheme,
        debugShowCheckedModeBanner: false,
        routes: {
          '/main': (context) => const MainNavigation(),
          '/login': (context) => const LoginPage(),
          '/signup': (context) => const SignUpPage(),
          '/profile': (context) => const ProfilePage(),
          '/home': (context) => const HomePage(),
          '/favourites': (context) => const FavouritePage(),
          '/forgetPassword': (context) => const ForgetPasswordScreen(),
        },
        home: const SplashScreen(),
      ),
    );
  }
}
