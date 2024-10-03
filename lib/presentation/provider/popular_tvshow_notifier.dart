import 'package:ditonton/common/state_enum.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/tvshow.dart';
import '../../domain/usecases/get_popular_tvshows.dart';

class PopularTvshowNotifier extends ChangeNotifier {
  final GetPopularTvshows getPopularTvshows;

  PopularTvshowNotifier({required this.getPopularTvshows});

  var _popularTvshows = <Tvshow>[];
  List<Tvshow> get popularTvshows => _popularTvshows;

  RequestState _popularTvshowsState = RequestState.Empty;
  RequestState get popularTvshowsState => _popularTvshowsState;

  String _message = '';
  String get message => _message;

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
}
