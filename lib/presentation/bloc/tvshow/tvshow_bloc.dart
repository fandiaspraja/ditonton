import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tvshow.dart';
import 'package:ditonton/domain/usecases/get_airing_today_tvshows.dart';
import 'package:ditonton/domain/usecases/get_ontheair_tvshows.dart';
import 'package:ditonton/domain/usecases/get_popular_tvshows.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tvshows.dart';
import 'package:ditonton/domain/usecases/get_tvshow_detail.dart';
import 'package:ditonton/domain/usecases/get_tvshow_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status_tvshow.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tvshows.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tvshow.dart';
import 'package:ditonton/domain/usecases/search_tvshows.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tvshow.dart';

import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../domain/entities/tvshow_detail.dart';

part 'tvshow_event.dart';
part 'tvshow_state.dart';

class AiringTodayTvshowBloc extends Bloc<TvshowEventBloc, TvshowStateBloc> {
  final GetAiringTodayTvshows _getAiringTodayTvshows;

  AiringTodayTvshowBloc(this._getAiringTodayTvshows) : super(TvshowLoading()) {
    on<FetchAiringTodayTvshows>((event, emit) async {
      emit(TvshowLoading());
      final result = await _getAiringTodayTvshows.execute();
      result.fold((failure) {
        emit(TvshowsError(failure.message));
      }, (data) {
        emit(TvshowsHasData(data));
      });
    });
  }
}

class OnTheAirTvshowBloc extends Bloc<TvshowEventBloc, TvshowStateBloc> {
  final GetOntheairTvshows _getOntheairTvshows;

  OnTheAirTvshowBloc(this._getOntheairTvshows) : super(TvshowLoading()) {
    on<FetchOntheairTvshows>((event, emit) async {
      emit(TvshowLoading());
      final result = await _getOntheairTvshows.execute();
      result.fold((failure) {
        emit(TvshowsError(failure.message));
      }, (data) {
        emit(TvshowsHasData(data));
      });
    });
  }
}

class PopularTvshowBloc extends Bloc<TvshowEventBloc, TvshowStateBloc> {
  final GetPopularTvshows _getPopularTvshows;

  PopularTvshowBloc(this._getPopularTvshows) : super(TvshowLoading()) {
    on<FetchPopularTvshows>((event, emit) async {
      emit(TvshowLoading());
      final result = await _getPopularTvshows.execute();
      result.fold((failure) {
        emit(TvshowsError(failure.message));
      }, (data) {
        emit(TvshowsHasData(data));
      });
    });
  }
}

class TopRatedTvshowBloc extends Bloc<TvshowEventBloc, TvshowStateBloc> {
  final GetTopRatedTvshows _getTopRatedTvshows;

  TopRatedTvshowBloc(this._getTopRatedTvshows) : super(TvshowLoading()) {
    on<FetchTopRatedTvshows>((event, emit) async {
      emit(TvshowLoading());
      final result = await _getTopRatedTvshows.execute();
      result.fold((failure) {
        emit(TvshowsError(failure.message));
      }, (data) {
        emit(TvshowsHasData(data));
      });
    });
  }
}

class TvshowDetailBloc extends Bloc<TvshowEventBloc, TvshowStateBloc> {
  final GetTvshowDetail _getTvshowDetail;

  TvshowDetailBloc(this._getTvshowDetail) : super(TvshowLoading()) {
    on<FetchTvshowDetail>((event, emit) async {
      final id = event.id;

      emit(TvshowLoading());

      final result = await _getTvshowDetail.execute(id);
      result.fold((failure) {
        emit(TvshowsError(failure.message));
      }, (data) {
        emit(TvshowDetailState(data));
      });
    });
  }
}

class TvshowRecommendationBloc extends Bloc<TvshowEventBloc, TvshowStateBloc> {
  final GetTvshowRecommendations _getTvshowRecommendations;

  TvshowRecommendationBloc(this._getTvshowRecommendations)
      : super(TvshowLoading()) {
    on<FetchTvshowRecommendation>((event, emit) async {
      final id = event.id;

      emit(TvshowLoading());

      final result = await _getTvshowRecommendations.execute(id);
      result.fold((failure) {
        emit(TvshowsError(failure.message));
      }, (data) {
        emit(TvshowsHasData(data));
      });
    });
  }
}

class WatchlistTvshowBloc extends Bloc<TvshowEventBloc, TvshowStateBloc> {
  final GetWatchlistTvshows _getWatchlistTvshows;
  final GetWatchListStatusTvshow _getWatchListStatusTvshow;
  final SaveWatchlistTvshow _saveWatchistTvshow;
  final RemoveWatchlistTvshow _removeWatchlistTvshow;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  WatchlistTvshowBloc(this._getWatchlistTvshows, this._getWatchListStatusTvshow,
      this._saveWatchistTvshow, this._removeWatchlistTvshow)
      : super(TvshowsEmpty()) {
    on<FetchWatchlistTvshows>(
      (event, emit) async {
        emit(TvshowLoading());

        final result = await _getWatchlistTvshows.execute();
        result.fold((failure) {
          emit(TvshowsError(failure.message));
        }, (data) {
          emit(WatchlistTvshowsState(data));
        });
      },
    );

    on<SaveWatchistTv>((event, emit) async {
      final movie = event.tvshow;
      emit(TvshowLoading());
      final result = await _saveWatchistTvshow.execute(movie);

      result.fold((failure) => emit(TvshowsError(failure.message)),
          (data) => emit(WatchlistTvshowMessage(data)));
    });

    on<RemoveWatchlistTvshowEvent>((event, emit) async {
      final movie = event.tvshow;
      emit(TvshowLoading());
      final result = await _removeWatchlistTvshow.execute(movie);

      result.fold((failure) => emit(TvshowsError(failure.message)),
          (data) => emit(WatchlistTvshowMessage(data)));
    });

    on<WatchlistTvshowStatus>((event, emit) async {
      final id = event.id;
      emit(TvshowLoading());
      final result = await _getWatchListStatusTvshow.execute(id);

      emit(WatchlistTvshowStatusState(result));
    });
  }
}

/// SEARCH MOVIE
class SearchTvshowBloc extends Bloc<SearchTvshowEvent, SearchState> {
  final SearchTvshows _searchTvshows;

  SearchTvshowBloc(this._searchTvshows) : super(SearchEmpty()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;

      emit(SearchLoading());

      final result = await _searchTvshows.execute(query);

      result.fold(
        (failure) {
          emit(SearchError(failure.message));
        },
        (data) {
          emit(SearchHasData(data));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
