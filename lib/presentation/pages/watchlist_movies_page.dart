import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/domain/entities/tvshow.dart';
import 'package:ditonton/presentation/bloc/movie/movie_bloc.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../widgets/tvshow_card_list.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();

    Future.microtask(
        () => context.read<WatchlistBloc>().add(FetchWatchlistMovies()));
    // Future.microtask(() =>
    //     Provider.of<WatchlistMovieNotifier>(context, listen: false)
    //         .fetchWatchlistMovies());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    context.read<WatchlistBloc>().add(FetchWatchlistMovies());
    // Provider.of<WatchlistMovieNotifier>(context, listen: false)
    //     .fetchWatchlistMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistBloc, MovieStateBloc>(
          builder: (context, state) {
            if (state is MoviesLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WatchlistMovieState) {
              if (state.movies.length < 1) {
                return Center(
                  child: Text('No movies added yet'),
                );
              } else {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final movie = state.movies[index];
                    if (movie.type == "tvshow") {
                      var tvshow = Tvshow.watchlist(
                        id: movie.id,
                        overview: movie.overview,
                        posterPath: movie.posterPath,
                        originalName: movie.title,
                        type: movie.type,
                      );
                      return TvshowCard(tvshow);
                    } else {
                      return MovieCard(movie);
                    }
                  },
                  itemCount: state.movies.length,
                );
              }
            } else if (state is MoviesError) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return Text('can\'t load data');
            }
          },
        ),

        // Consumer<WatchlistMovieNotifier>(
        //   builder: (context, data, child) {
        //     if (data.watchlistState == RequestState.Loading) {
        //       return Center(
        //         child: CircularProgressIndicator(),
        //       );
        //     } else if (data.watchlistState == RequestState.Loaded) {
        //       return ListView.builder(
        //         itemBuilder: (context, index) {
        //           final movie = data.watchlistMovies[index];

        //           if (movie.type == "tvshow") {
        //             var tvshow = Tvshow.watchlist(
        //               id: movie.id,
        //               overview: movie.overview,
        //               posterPath: movie.posterPath,
        //               originalName: movie.title,
        //               type: movie.type,
        //             );
        //             return TvshowCard(tvshow);
        //           } else {
        //             return MovieCard(movie);
        //           }
        //         },
        //         itemCount: data.watchlistMovies.length,
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

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
