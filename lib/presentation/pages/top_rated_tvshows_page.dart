import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/ontheair_tvshow_notifier.dart';
import 'package:ditonton/presentation/provider/popular_movies_notifier.dart';
import 'package:ditonton/presentation/provider/popular_tvshow_notifier.dart';
import 'package:ditonton/presentation/provider/top_rated_tvshow_notifier.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:ditonton/presentation/widgets/tvshow_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopRatedTvshowsPage extends StatefulWidget {
  static const ROUTE_NAME = '/toprated-tvshows';

  @override
  _TopRatedTvshowsPageState createState() => _TopRatedTvshowsPageState();
}

class _TopRatedTvshowsPageState extends State<TopRatedTvshowsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<TopRatedTvshowNotifier>(context, listen: false)
            .fetchTopRatedTvshows());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated Tv Shows'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TopRatedTvshowNotifier>(
          builder: (context, data, child) {
            if (data.topRatedTvshowsState == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.topRatedTvshowsState == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = data.topRatedTvshows[index];
                  return TvshowCard(tv);
                },
                itemCount: data.topRatedTvshows.length,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }
}
