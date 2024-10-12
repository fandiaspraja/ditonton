import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/bloc/tvshow/tvshow_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

class OnTheAirTvshowEventHelper extends Fake implements TvshowEventBloc {}

class OnTheAirTvshowStateHelper extends Fake implements TvshowStateBloc {}

class OnTheAirTvshowBlocHelper
    extends MockBloc<TvshowEventBloc, TvshowStateBloc>
    implements OnTheAirTvshowBloc {}

class PopularTvshowEventHelper extends Fake implements TvshowEventBloc {}

class PopularTvshowStateHelper extends Fake implements TvshowStateBloc {}

class PopularTvshowBlocHelper extends MockBloc<TvshowEventBloc, TvshowStateBloc>
    implements PopularTvshowBloc {}

class TopRatedTvshowEventHelper extends Fake implements TvshowEventBloc {}

class TopRatedTvshowStateHelper extends Fake implements TvshowStateBloc {}

class TopRatedTvshowBlocHelper
    extends MockBloc<TvshowEventBloc, TvshowStateBloc>
    implements TopRatedTvshowBloc {}

class TvshowDetailEventHelper extends Fake implements TvshowEventBloc {}

class TvshowDetailStateHelper extends Fake implements TvshowStateBloc {}

class TvshowDetailBlocHelper extends MockBloc<TvshowEventBloc, TvshowStateBloc>
    implements TvshowDetailBloc {}

class RecommendationsTvshowEventHelper extends Fake
    implements TvshowEventBloc {}

class RecommendationsTvshowStateHelper extends Fake
    implements TvshowStateBloc {}

class RecommendationsTvshowBlocHelper
    extends MockBloc<TvshowEventBloc, TvshowStateBloc>
    implements TvshowRecommendationBloc {}

class WatchlistTvshowEventHelper extends Fake implements TvshowEventBloc {}

class WatchlistTvshowtateHelper extends Fake implements TvshowStateBloc {}

class WatchlistTvshowBlocHelper
    extends MockBloc<TvshowEventBloc, TvshowStateBloc>
    implements WatchlistTvshowBloc {}
