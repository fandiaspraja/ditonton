import 'package:ditonton/domain/usecases/get_airing_today_tvshows.dart';
import 'package:ditonton/domain/usecases/get_ontheair_tvshows.dart';
import 'package:ditonton/domain/usecases/get_popular_tvshows.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tvshows.dart';
import 'package:flutter/foundation.dart';

import '../../common/state_enum.dart';
import '../../domain/entities/tvshow.dart';

class TvshowListNotifier extends ChangeNotifier {
  var _airingTodayTvshows = <Tvshow>[];
  List<Tvshow> get airingTodayTvshows => _airingTodayTvshows;

  RequestState _airingTodayTvshowsState = RequestState.Empty;
  RequestState get airingTodayTvshowsState => _airingTodayTvshowsState;

  var _onTheAirTvshows = <Tvshow>[];
  List<Tvshow> get onTheAirTvshows => _onTheAirTvshows;

  RequestState _onTheAirTvshowsState = RequestState.Empty;
  RequestState get onTheAirTvshowsState => _onTheAirTvshowsState;

  var _popularTvshows = <Tvshow>[];
  List<Tvshow> get popularTvshows => _popularTvshows;

  RequestState _popularTvshowsState = RequestState.Empty;
  RequestState get popularTvshowsState => _popularTvshowsState;

  var _topRatedTvshows = <Tvshow>[];
  List<Tvshow> get topRatedTvshows => _topRatedTvshows;

  RequestState _topRatedTvshowsState = RequestState.Empty;
  RequestState get topRatedTvshowsState => _topRatedTvshowsState;

  String _message = '';
  String get message => _message;

  final GetAiringTodayTvshows getAiringTodayTvshows;
  final GetOntheairTvshows getOntheairTvshows;
  final GetPopularTvshows getPopularTvshows;
  final GetTopRatedTvshows getTopRatedTvshows;

  TvshowListNotifier({
    required this.getAiringTodayTvshows,
    required this.getOntheairTvshows,
    required this.getPopularTvshows,
    required this.getTopRatedTvshows,
  });

  Future<void> fetchAiringTodayTvshows() async {
    _airingTodayTvshowsState = RequestState.Loading;

    notifyListeners();

    final result = await getAiringTodayTvshows.execute();
    result.fold(
      (failure) {
        _airingTodayTvshowsState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _airingTodayTvshowsState = RequestState.Loaded;
        _airingTodayTvshows = moviesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchOntheairTvshows() async {
    _onTheAirTvshowsState = RequestState.Loading;
    notifyListeners();

    final result = await getOntheairTvshows.execute();
    result.fold(
      (failure) {
        _onTheAirTvshowsState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _onTheAirTvshowsState = RequestState.Loaded;
        _onTheAirTvshows = moviesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularTvshows() async {
    _popularTvshowsState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTvshows.execute();
    result.fold(
      (failure) {
        _popularTvshowsState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _popularTvshowsState = RequestState.Loaded;
        _popularTvshows = moviesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedTvshows() async {
    _topRatedTvshowsState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTvshows.execute();
    result.fold(
      (failure) {
        _topRatedTvshowsState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _topRatedTvshowsState = RequestState.Loaded;
        _topRatedTvshows = moviesData;
        notifyListeners();
      },
    );
  }
}
