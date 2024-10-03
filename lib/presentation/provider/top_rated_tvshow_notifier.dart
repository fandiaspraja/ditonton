import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_ontheair_tvshows.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tvshows.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/tvshow.dart';

class TopRatedTvshowNotifier extends ChangeNotifier {
  final GetTopRatedTvshows getTopRatedTvshows;

  TopRatedTvshowNotifier({required this.getTopRatedTvshows});

  var _topRatedTvshows = <Tvshow>[];
  List<Tvshow> get topRatedTvshows => _topRatedTvshows;

  RequestState _topRatedTvshowsState = RequestState.Empty;
  RequestState get topRatedTvshowsState => _topRatedTvshowsState;

  String _message = '';
  String get message => _message;

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
