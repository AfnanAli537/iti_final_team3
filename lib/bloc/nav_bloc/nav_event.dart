part of 'nav_bloc.dart';

abstract class NavigationEvent {}

class NavigateTo extends NavigationEvent {
  final int pageIndex;
  NavigateTo(this.pageIndex);
}
