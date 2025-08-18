import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iti_final_team3/bloc/search_bloc/search_bloc.dart';
import 'package:iti_final_team3/data/repo/image_repo.dart';

import 'package:iti_final_team3/utils/app_strings.dart';
import 'package:iti_final_team3/widget/form_feild.dart';
import 'package:iti_final_team3/widget/grid_view.dart';
import 'package:iti_final_team3/widget/show_toast.dart';

import 'package:lottie/lottie.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    return BlocConsumer<SearchBloc, SearchState>(listener: (context, state) {
      if (state is SearchError) {
        AppToast.showToast(AppStrings.noResult, Colors.red);
        context.read<SearchBloc>().add(ClearSearchEvent());
      }
    }, builder: (context, state) {
      return Scaffold(
        appBar: AppBar(title: const Text(AppStrings.search)),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: AppTextField(
                  controller: searchController,
                  prefixIcon: const Icon(Icons.search_rounded),
                  textContent: AppStrings.feildResult,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      searchController.clear();
                      context.read<SearchBloc>().add(ClearSearchEvent());
                    },
                  ),
                  onChanged: (query) {
                    context
                        .read<SearchBloc>()
                        .add(SearchQueryChanged(query.trim()));
                  },
                ),
              ),
              // const SizedBox(height: 90),
              BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state is SearchInitial) {
                    return Center(
                      child: Lottie.asset(
                        'assets/lottie/search imm.json',
                      ),
                    );
                  } else if (state is SearchLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is SearchResultEmpty) {
                    return const Center(child: Text(AppStrings.noResult));
                  } else if (state is SearchLoaded) {
                    return Padding(
                      padding: const EdgeInsets.all(12),
                      child: ImagesGridView(
                          allImages: state.results.map((e) => e.url).toList()),
                    );
                  }
                  return const Center(child: Text("welcome"));
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
