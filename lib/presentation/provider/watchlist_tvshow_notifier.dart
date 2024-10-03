import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tvshow.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tvshows.dart';
import 'package:flutter/material.dart';

class WatchlistTvshowNotifier extends ChangeNotifier {
  var _watchlistTvshows = <Tvshow>[];
  List<Tvshow> get watchlistTvshows => _watchlistTvshows;

  var _watchlistState = RequestState.Empty;
  RequestState get watchlistState => _watchlistState;

  String _message = '';
  String get message => _message;

  WatchlistTvshowNotifier({required this.getWatchlistTvshows});

  final GetWatchlistTvshows getWatchlistTvshows;

  Future<void> fetchWatchlistMovies() async {
    _watchlistState = RequestState.Loading;
    notifyListeners();

    final result = await getWatchlistTvshows.execute();
    result.fold(
      (failure) {
        _watchlistState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvshowsData) {
        _watchlistState = RequestState.Loaded;
        _watchlistTvshows = tvshowsData;
        notifyListeners();
      },
    );
  }
}
