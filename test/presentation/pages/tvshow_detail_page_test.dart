import 'package:ditonton/presentation/bloc/movie/movie_bloc.dart';
import 'package:ditonton/presentation/bloc/tvshow/tvshow_bloc.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/tvshow_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper_tvhsow_bloc.dart';

void main() {
  late TvshowDetailBlocHelper tvshowDetailBlocHelper;
  late RecommendationsTvshowBlocHelper recommendationsTvshowBlocHelper;
  late WatchlistTvshowBlocHelper watchlistTvshowBlocHelper;

  setUpAll(() {
    tvshowDetailBlocHelper = TvshowDetailBlocHelper();
    registerFallbackValue(TvshowDetailEventHelper());
    registerFallbackValue(TvshowDetailStateHelper());

    recommendationsTvshowBlocHelper = RecommendationsTvshowBlocHelper();
    registerFallbackValue(RecommendationsTvshowEventHelper());
    registerFallbackValue(RecommendationsTvshowStateHelper());

    watchlistTvshowBlocHelper = WatchlistTvshowBlocHelper();
    registerFallbackValue(WatchlistTvshowEventHelper());
    registerFallbackValue(WatchlistTvshowtateHelper());
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TvshowDetailBloc>(create: (_) => tvshowDetailBlocHelper),
        BlocProvider<WatchlistTvshowBloc>(
          create: (_) => watchlistTvshowBlocHelper,
        ),
        BlocProvider<TvshowRecommendationBloc>(
          create: (_) => recommendationsTvshowBlocHelper,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => tvshowDetailBlocHelper.state).thenReturn(TvshowLoading());
    when(() => watchlistTvshowBlocHelper.state).thenReturn(TvshowLoading());
    when(() => recommendationsTvshowBlocHelper.state)
        .thenReturn(TvshowLoading());

    final circularProgress = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(TvshowDetailPage(
      id: 1,
    )));
    await tester.pump();

    expect(circularProgress, findsOneWidget);
  });
  testWidgets(
      'Watchlist button should display + icon when movie not added to watch list',
      (WidgetTester tester) async {
    when(() => tvshowDetailBlocHelper.state)
        .thenReturn(TvshowDetailState(testTvshowDetail));
    when(() => recommendationsTvshowBlocHelper.state)
        .thenReturn(TvshowsHasData(testTvshowList));
    when(() => watchlistTvshowBlocHelper.state)
        .thenReturn(WatchlistTvshowStatusState(false));

    final watchListButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(TvshowDetailPage(id: 97080)));
    await tester.pump();
    expect(watchListButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display check icon when movie added to watch list',
      (WidgetTester tester) async {
    when(() => tvshowDetailBlocHelper.state)
        .thenReturn(TvshowDetailState(testTvshowDetail));

    when(() => recommendationsTvshowBlocHelper.state)
        .thenReturn(TvshowsHasData(testTvshowList));
    when(() => watchlistTvshowBlocHelper.state)
        .thenReturn(WatchlistTvshowStatusState(true));

    final watchListButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(TvshowDetailPage(id: 97080)));
    expect(watchListButtonIcon, findsOneWidget);
  });
}
