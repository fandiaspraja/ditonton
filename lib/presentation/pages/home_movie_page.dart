import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tvshow.dart';
import 'package:ditonton/domain/entities/tvshow_detail.dart';
import 'package:ditonton/presentation/bloc/movie/movie_bloc.dart';
import 'package:ditonton/presentation/bloc/tvshow/tvshow_bloc.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/ontheair_tvshows_page.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/popular_tvshows_page.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:ditonton/presentation/pages/search_tvshows_page.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/top_rated_tvshows_page.dart';
import 'package:ditonton/presentation/pages/tvshow_detail_page.dart';
import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class HomeMoviePage extends StatefulWidget {
  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  var type = 'movie';
  @override
  void initState() {
    super.initState();
    // Future.microtask(
    //     () => Provider.of<MovieListNotifier>(context, listen: false)
    //       ..fetchNowPlayingMovies()
    //       ..fetchPopularMovies()
    //       ..fetchTopRatedMovies());

    Future.microtask(() {
      context.read<NowPlayingMovieBloc>().add(FetchNowPlayingMovies());
      context.read<PopularMovieBloc>().add(FetchPopularMovies());
      context.read<TopRatedMovieBloc>().add(FetchTopRatedMovies());

      context.read<AiringTodayTvshowBloc>().add(FetchAiringTodayTvshows());
      context.read<OnTheAirTvshowBloc>().add(FetchOntheairTvshows());
      context.read<PopularTvshowBloc>().add(FetchPopularTvshows());
      context.read<TopRatedTvshowBloc>().add(FetchTopRatedTvshows());
    });

    // Future.microtask(
    //     () => Provider.of<TvshowListNotifier>(context, listen: false)
    //       ..fetchAiringTodayTvshows()
    //       ..fetchOntheairTvshows()
    //       ..fetchPopularTvshows()
    //       ..fetchTopRatedTvshows());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
                backgroundColor: Colors.grey.shade900,
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
              ),
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('Movies'),
              onTap: () {
                setState(() {
                  type = 'movie';
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.tv),
              title: Text('Tv Series'),
              onTap: () {
                setState(() {
                  type = 'tv';
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistMoviesPage.ROUTE_NAME);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              if (type == 'movie') {
                Navigator.pushNamed(context, SearchPage.ROUTE_NAME);
              } else if (type == 'tv') {
                Navigator.pushNamed(context, SearchTvshowsPage.ROUTE_NAME);
              }
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: (type == 'movie')
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Now Playing',
                      style: kHeading6,
                    ),
                    BlocBuilder<NowPlayingMovieBloc, MovieStateBloc>(
                        builder: (context, state) {
                      if (state is MoviesLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is MoviesHasData) {
                        return MovieList(state.movie);
                      } else if (state is MoviesError) {
                        return Center(
                          child: Text(state.message),
                        );
                      } else {
                        return Center(
                          child: Text('No Movies Data'),
                        );
                      }
                    }),
                    _buildSubHeading(
                      title: 'Popular',
                      onTap: () => Navigator.pushNamed(
                          context, PopularMoviesPage.ROUTE_NAME),
                    ),
                    BlocBuilder<PopularMovieBloc, MovieStateBloc>(
                        builder: (context, state) {
                      if (state is MoviesLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is MoviesHasData) {
                        return MovieList(state.movie);
                      } else if (state is MoviesError) {
                        return Center(
                          child: Text(state.message),
                        );
                      } else {
                        return Center(
                          child: Text('No Movies Data'),
                        );
                      }
                    }),
                    _buildSubHeading(
                      title: 'Top Rated',
                      onTap: () => Navigator.pushNamed(
                          context, TopRatedMoviesPage.ROUTE_NAME),
                    ),
                    BlocBuilder<TopRatedMovieBloc, MovieStateBloc>(
                        builder: (context, state) {
                      if (state is MoviesLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is MoviesHasData) {
                        return MovieList(state.movie);
                      } else if (state is MoviesError) {
                        return Center(
                          child: Text(state.message),
                        );
                      } else {
                        return Center(
                          child: Text('No Movies Data'),
                        );
                      }
                    }),
                  ],
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Airing Today',
                      style: kHeading6,
                    ),
                    BlocBuilder<AiringTodayTvshowBloc, TvshowStateBloc>(
                        builder: (context, state) {
                      if (state is TvshowLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is TvshowsHasData) {
                        return TvshowList(state.tvshow);
                      } else if (state is TvshowsError) {
                        return Center(
                          child: Text(state.message),
                        );
                      } else {
                        return Center(
                          child: Text('No Tvshows Data'),
                        );
                      }
                    }),
                    _buildSubHeading(
                      title: 'On The Air',
                      onTap: () => Navigator.pushNamed(
                          context, OntheairTvshowsPage.ROUTE_NAME),
                    ),
                    BlocBuilder<OnTheAirTvshowBloc, TvshowStateBloc>(
                        builder: (context, state) {
                      if (state is TvshowLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is TvshowsHasData) {
                        return TvshowList(state.tvshow);
                      } else if (state is TvshowsError) {
                        return Center(
                          child: Text(state.message),
                        );
                      } else {
                        return Center(
                          child: Text('No Tvshows Data'),
                        );
                      }
                    }),
                    _buildSubHeading(
                      title: 'Popular',
                      onTap: () => Navigator.pushNamed(
                          context, PopularTvshowsPage.ROUTE_NAME),
                    ),
                    BlocBuilder<PopularTvshowBloc, TvshowStateBloc>(
                        builder: (context, state) {
                      if (state is TvshowLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is TvshowsHasData) {
                        return TvshowList(state.tvshow);
                      } else if (state is TvshowsError) {
                        return Center(
                          child: Text(state.message),
                        );
                      } else {
                        return Center(
                          child: Text('No Tvshows Data'),
                        );
                      }
                    }),
                    _buildSubHeading(
                      title: 'Top Rated',
                      onTap: () => Navigator.pushNamed(
                          context, TopRatedTvshowsPage.ROUTE_NAME),
                    ),
                    BlocBuilder<TopRatedTvshowBloc, TvshowStateBloc>(
                        builder: (context, state) {
                      if (state is TvshowLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is TvshowsHasData) {
                        return TvshowList(state.tvshow);
                      } else if (state is TvshowsError) {
                        return Center(
                          child: Text(state.message),
                        );
                      } else {
                        return Center(
                          child: Text('No Tvshows Data'),
                        );
                      }
                    }),
                  ],
                ),
              ),
            ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  MovieList(this.movies);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MovieDetailPage.ROUTE_NAME,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}

class TvshowList extends StatelessWidget {
  final List<Tvshow> tvshows;

  TvshowList(this.tvshows);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tvshow = tvshows[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TvshowDetailPage.ROUTE_NAME,
                  arguments: tvshow.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tvshow.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvshows.length,
      ),
    );
  }
}
