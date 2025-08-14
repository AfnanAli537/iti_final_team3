import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iti_final_team3/bloc/home_bloc/image_bloc.dart';
import 'package:iti_final_team3/bloc/login_bloc/login_bloc.dart';
import 'package:iti_final_team3/bloc/nav_bloc/nav_bloc.dart';
import 'package:iti_final_team3/bloc/signup_bloc/signup_bloc.dart';
import 'package:iti_final_team3/bloc/splash_bloc/splash_bloc.dart';
import 'package:iti_final_team3/bloc/upload_data/upload_bloc.dart';
import 'package:iti_final_team3/data/models/auth_repo.dart';
import 'package:iti_final_team3/data/repo/image_repo.dart';
import 'package:iti_final_team3/screens/home_screen.dart';
import 'package:iti_final_team3/screens/main_nav.dart';
import 'package:iti_final_team3/screens/splash_screen.dart';
import 'package:iti_final_team3/screens/upload_screen.dart';
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
        BlocProvider(
          create: (_) => ImageBloc(ImageRepository())..add(LoadImages()),
        ),
        BlocProvider(create: (_) => SplashBloc()),
        BlocProvider(
          create: (_) => UploadBloc(repository: ImageRepository()),
        ),
        BlocProvider(
          create: (_) => NavigationBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'inspiration App',
        themeMode: ThemeMode.light,
        theme: AppThemes.lightTheme,
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
