import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_ontheair_tvshows.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/tvshow.dart';

class OntheairTvshowNotifier extends ChangeNotifier {
  final GetOntheairTvshows getOntheairTvshows;

  OntheairTvshowNotifier({required this.getOntheairTvshows});

  var _onTheAirTvshows = <Tvshow>[];
  List<Tvshow> get onTheAirTvshows => _onTheAirTvshows;

  RequestState _onTheAirTvshowsState = RequestState.Empty;
  RequestState get onTheAirTvshowsState => _onTheAirTvshowsState;

  String _message = '';
  String get message => _message;

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
}
