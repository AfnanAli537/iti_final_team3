part of 'search_bloc.dart';

class SearchEvent {}

class SearchQueryChanged extends SearchEvent {
  final String query;

  SearchQueryChanged(this.query);
}

class ClearSearchEvent extends SearchEvent {}
