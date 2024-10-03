import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/datasources/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/data/repositories/tvshow_repository_impl.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/tvshow_repository.dart';
import 'package:ditonton/domain/usecases/get_airing_today_tvshows.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_ontheair_tvshows.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_tvshows.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tvshows.dart';
import 'package:ditonton/domain/usecases/get_tvshow_detail.dart';
import 'package:ditonton/domain/usecases/get_tvshow_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status_tvshow.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tvshows.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tvshow.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tvshow.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/domain/usecases/search_tvshows.dart';
import 'package:ditonton/presentation/provider/movie_detail_notifier.dart';
import 'package:ditonton/presentation/provider/movie_list_notifier.dart';
import 'package:ditonton/presentation/provider/movie_search_notifier.dart';
import 'package:ditonton/presentation/provider/ontheair_tvshow_notifier.dart';
import 'package:ditonton/presentation/provider/popular_movies_notifier.dart';
import 'package:ditonton/presentation/provider/popular_tvshow_notifier.dart';
import 'package:ditonton/presentation/provider/top_rated_movies_notifier.dart';
import 'package:ditonton/presentation/provider/top_rated_tvshow_notifier.dart';
import 'package:ditonton/presentation/provider/tvshow_detail_notifier.dart';
import 'package:ditonton/presentation/provider/tvshow_list_notifier.dart';
import 'package:ditonton/presentation/provider/tvshow_search_notifier.dart';
import 'package:ditonton/presentation/provider/watchlist_movie_notifier.dart';
import 'package:ditonton/presentation/provider/watchlist_tvshow_notifier.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(
    () => MovieListNotifier(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => TvshowListNotifier(
      getAiringTodayTvshows: locator(),
      getOntheairTvshows: locator(),
      getPopularTvshows: locator(),
      getTopRatedTvshows: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailNotifier(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => TvshowDetailNotifier(
      getTvshowDetail: locator(),
      getTvshowRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieSearchNotifier(
      searchMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => TvshowSearchNotifier(
      searchTvshows: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesNotifier(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => OntheairTvshowNotifier(
      getOntheairTvshows: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularTvshowNotifier(
      getPopularTvshows: locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedTvshowNotifier(
      getTopRatedTvshows: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieNotifier(
      getWatchlistMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistTvshowNotifier(
      getWatchlistTvshows: locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));
  locator.registerLazySingleton(() => GetAiringTodayTvshows(locator()));
  locator.registerLazySingleton(() => GetOntheairTvshows(locator()));
  locator.registerLazySingleton(() => GetPopularTvshows(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvshows(locator()));
  locator.registerLazySingleton(() => GetTvshowDetail(locator()));
  locator.registerLazySingleton(() => GetTvshowRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTvshows(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvshows(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTvshow(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTvshow(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusTvshow(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  locator.registerLazySingleton<TvshowRepository>(
    () => TvshowRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());
}
