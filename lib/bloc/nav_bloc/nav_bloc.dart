import 'package:flutter_bloc/flutter_bloc.dart';
part 'nav_event.dart';
part 'nav_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationState(0)) {
    on<NavigateTo>(_onNavigateTo);
  }

  void _onNavigateTo(event, emit) {
    emit(NavigationState(event.pageIndex));
  }
}
