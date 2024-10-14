import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/bloc/tvshow/tvshow_bloc.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:ditonton/presentation/widgets/tvshow_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class OntheairTvshowsPage extends StatefulWidget {
  static const ROUTE_NAME = '/ontheair-tvshows';

  @override
  _OntheairTvshowPageState createState() => _OntheairTvshowPageState();
}

class _OntheairTvshowPageState extends State<OntheairTvshowsPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(
        () => context.read<OnTheAirTvshowBloc>().add(FetchOntheairTvshows()));

    // Future.microtask(() =>
    //     Provider.of<OntheairTvshowNotifier>(context, listen: false)
    //         .fetchOntheairTvshows());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('On The Air Tv Shows'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<OnTheAirTvshowBloc, TvshowStateBloc>(
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
        // Consumer<OntheairTvshowNotifier>(
        //   builder: (context, data, child) {
        //     if (data.onTheAirTvshowsState == RequestState.Loading) {
        //       return Center(
        //         child: CircularProgressIndicator(),
        //       );
        //     } else if (data.onTheAirTvshowsState == RequestState.Loaded) {
        //       return ListView.builder(
        //         itemBuilder: (context, index) {
        //           final tv = data.onTheAirTvshows[index];
        //           return TvshowCard(tv);
        //         },
        //         itemCount: data.onTheAirTvshows.length,
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
