import 'package:ditonton/domain/entities/tvshow.dart';
import 'package:ditonton/domain/usecases/search_tvshows.dart';
import 'package:flutter/material.dart';

import '../../common/state_enum.dart';

class TvshowSearchNotifier extends ChangeNotifier {
  final SearchTvshows searchTvshows;

  TvshowSearchNotifier({required this.searchTvshows});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Tvshow> _searchResult = [];
  List<Tvshow> get searchResult => _searchResult;

  String _message = '';
  String get message => _message;

  Future<void> fetchTvshowSearch(String query) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await searchTvshows.execute(query);
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (data) {
        _searchResult = data;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
