import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/bloc/tvshow/tvshow_bloc.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:ditonton/presentation/widgets/tvshow_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class PopularTvshowsPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-tvshows';

  @override
  _PopularTvshowsPageState createState() => _PopularTvshowsPageState();
}

class _PopularTvshowsPageState extends State<PopularTvshowsPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(
        () => context.read<PopularTvshowBloc>().add(FetchPopularTvshows()));
    // Future.microtask(() =>
    //     Provider.of<PopularTvshowNotifier>(context, listen: false)
    //         .fetchPopularTvshows());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Tv Shows'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularTvshowBloc, TvshowStateBloc>(
          builder: (context, state) {
            if (state is TvshowLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is TvshowsHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvShow = state.tvshow[index];
                  return TvshowCard(tvShow);
                },
                itemCount: state.tvshow.length,
              );
            } else if (state is TvshowsError) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return Center(
                child: Text('No Tvshows'),
              );
            }
          },
        ),

        // Consumer<PopularTvshowNotifier>(
        //   builder: (context, data, child) {
        //     if (data.popularTvshowsState == RequestState.Loading) {
        //       return Center(
        //         child: CircularProgressIndicator(),
        //       );
        //     } else if (data.popularTvshowsState == RequestState.Loaded) {
        //       return ListView.builder(
        //         itemBuilder: (context, index) {
        //           final tv = data.popularTvshows[index];
        //           return TvshowCard(tv);
        //         },
        //         itemCount: data.popularTvshows.length,
        //       );
        //     } else {
        //       return Center(
        //         key: Key('error_message'),
        //         child: Text(data.message),
        //       );
        //     }
        //   },
        // ),
      ),
    );
  }
}
