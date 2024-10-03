import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/ontheair_tvshow_notifier.dart';
import 'package:ditonton/presentation/provider/popular_movies_notifier.dart';
import 'package:ditonton/presentation/provider/popular_tvshow_notifier.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:ditonton/presentation/widgets/tvshow_card_list.dart';
import 'package:flutter/material.dart';
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
    Future.microtask(() =>
        Provider.of<PopularTvshowNotifier>(context, listen: false)
            .fetchPopularTvshows());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Tv Shows'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<PopularTvshowNotifier>(
          builder: (context, data, child) {
            if (data.popularTvshowsState == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.popularTvshowsState == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = data.popularTvshows[index];
                  return TvshowCard(tv);
                },
                itemCount: data.popularTvshows.length,
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
