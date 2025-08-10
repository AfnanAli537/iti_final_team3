part of 'splash_bloc.dart';


 abstract class SplashState {
   SplashState();
}

class SplashInitial extends SplashState {}
class SplashLoading extends SplashState {}
class SplashFinished extends SplashState {}