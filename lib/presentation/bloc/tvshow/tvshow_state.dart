part of 'tvshow_bloc.dart';

abstract class TvshowStateBloc extends Equatable {
  const TvshowStateBloc();

  @override
  List<Object> get props => [];
}

class TvshowLoading extends TvshowStateBloc {}

class TvshowsEmpty extends TvshowStateBloc {}

class TvshowsHasData extends TvshowStateBloc {
  final List<Tvshow> tvshow;

  const TvshowsHasData(this.tvshow);

  @override
  List<Object> get props => [tvshow];
}

class TvshowsError extends TvshowStateBloc {
  final String message;

  const TvshowsError(this.message);

  @override
  List<Object> get props => [message];
}

class TvshowDetailState extends TvshowStateBloc {
  final TvshowDetail tvhsow;

  TvshowDetailState(this.tvhsow);

  @override
  List<Object> get props => [tvhsow];
}

class WatchlistTvshowsState extends TvshowStateBloc {
  final List<Tvshow> tvshows;

  WatchlistTvshowsState(this.tvshows);

  @override
  List<Object> get props => [tvshows];
}

class WatchlistTvshowMessage extends TvshowStateBloc {
  final String message;
  const WatchlistTvshowMessage(this.message);
  @override
  List<Object> get props => [message];
}

class WatchlistTvshowStatusState extends TvshowStateBloc {
  final bool status;

  const WatchlistTvshowStatusState(this.status);

  @override
  List<Object> get props => [status];
}

// SEARCH MOVIE
class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchEmpty extends SearchState {}

class SearchLoading extends SearchState {}

class SearchError extends SearchState {
  final String message;

  SearchError(this.message);

  @override
  List<Object> get props => [message];
}

class SearchHasData extends SearchState {
  final List<Tvshow> result;

  SearchHasData(this.result);

  @override
  List<Object> get props => [result];
}

class TvshowDetailDataState extends SearchState {
  final TvshowDetail tvshow;

  TvshowDetailDataState(this.tvshow);

  @override
  List<Object> get props => [tvshow];
}
