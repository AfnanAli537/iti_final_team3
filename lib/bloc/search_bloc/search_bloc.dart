import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iti_final_team3/data/repo/image_model.dart';
import 'package:iti_final_team3/data/repo/image_repo.dart';
import 'package:iti_final_team3/utils/app_strings.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final ImageRepository repository;

  SearchBloc(this.repository) : super(SearchInitial()) {
    on<SearchQueryChanged>(_onSearchQueryChanged);
    on<ClearSearchEvent>(_onClearSearchEvent);
  }
  Future<void> _onClearSearchEvent(event, emit) async {
    emit(SearchInitial());
  }

  Future<void> _onSearchQueryChanged(event, emit) async {
    if (event.query.isEmpty) {
      emit(SearchInitial());
    }

    emit(SearchLoading());
    try {
      await emit.forEach<List<ImageModel>>(
        repository.searchImages(event.query),
        onData: (images) {
          if (images.isEmpty) return SearchResultEmpty();
          return SearchLoaded(images);
        },
        onError: (_, __) => SearchError(AppStrings.serachFalid),
      );
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }
}
