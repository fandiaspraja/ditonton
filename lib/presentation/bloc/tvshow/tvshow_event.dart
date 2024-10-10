part of 'tvshow_bloc.dart';

abstract class TvshowEventBloc extends Equatable {
  const TvshowEventBloc();

  @override
  List<Object> get props => [];
}

class FetchAiringTodayTvshows extends TvshowEventBloc {}

class FetchOntheairTvshows extends TvshowEventBloc {}

class FetchPopularTvshows extends TvshowEventBloc {}

class FetchTopRatedTvshows extends TvshowEventBloc {}

class FetchWatchlistTvshows extends TvshowEventBloc {}

class FetchTvshowDetail extends TvshowEventBloc {
  final int id;

  FetchTvshowDetail(this.id);

  @override
  List<Object> get props => [id];
}

class FetchTvshowRecommendation extends TvshowEventBloc {
  final int id;
  const FetchTvshowRecommendation(this.id);

  @override
  List<Object> get props => [id];
}

class SaveWatchistTv extends TvshowEventBloc {
  final TvshowDetail tvshow;

  const SaveWatchistTv(this.tvshow);
  @override
  List<Object> get props => [tvshow];

  execute(TvshowDetail tvshow) {}
}

class RemoveWatchlistTvshowEvent extends TvshowEventBloc {
  final TvshowDetail tvshow;

  const RemoveWatchlistTvshowEvent(this.tvshow);
  @override
  List<Object> get props => [tvshow];

  execute(TvshowDetail movie) {}
}

class WatchlistTvshowStatus extends TvshowEventBloc {
  final int id;

  const WatchlistTvshowStatus(this.id);

  @override
  List<Object> get props => [id];
}

// SEARCH MOVIE
class SearchTvshowEvent extends Equatable {
  const SearchTvshowEvent();

  @override
  List<Object> get props => [];
}

class OnQueryChanged extends SearchTvshowEvent {
  final String query;

  OnQueryChanged(this.query);

  @override
  List<Object> get props => [query];
}
