import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/bloc/tvshow/tvshow_bloc.dart';
import 'package:ditonton/presentation/widgets/tvshow_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class SearchTvshowsPage extends StatelessWidget {
  static const ROUTE_NAME = '/searchtv';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onSubmitted: (query) {
                context.read<SearchTvshowBloc>().add(OnQueryChanged(query));

                // Provider.of<TvshowSearchNotifier>(context, listen: false)
                //     .fetchTvshowSearch(query);
              },
              decoration: InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            BlocBuilder<SearchTvshowBloc, SearchState>(
              builder: (context, state) {
                if (state is SearchLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is SearchHasData) {
                  final result = state.result;
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        final movie = result[index];
                        return TvshowCard(movie);
                      },
                      itemCount: result.length,
                    ),
                  );
                } else if (state is SearchError) {
                  return Expanded(
                    child: Center(
                      child: Text(state.message),
                    ),
                  );
                } else {
                  return Expanded(
                    child: Container(),
                  );
                }
              },
            ),
            // Consumer<TvshowSearchNotifier>(
            //   builder: (context, data, child) {
            //     if (data.state == RequestState.Loading) {
            //       return Center(
            //         child: CircularProgressIndicator(),
            //       );
            //     } else if (data.state == RequestState.Loaded) {
            //       final result = data.searchResult;
            //       return Expanded(
            //         child: ListView.builder(
            //           padding: const EdgeInsets.all(8),
            //           itemBuilder: (context, index) {
            //             final tv = data.searchResult[index];
            //             return TvshowCard(tv);
            //           },
            //           itemCount: result.length,
            //         ),
            //       );
            //     } else {
            //       return Expanded(
            //         child: Container(),
            //       );
            //     }
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
