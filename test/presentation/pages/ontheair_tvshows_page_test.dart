import 'package:ditonton/presentation/bloc/movie/movie_bloc.dart';
import 'package:ditonton/presentation/bloc/tvshow/tvshow_bloc.dart';
import 'package:ditonton/presentation/pages/ontheair_tvshows_page.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/popular_tvshows_page.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper_tvhsow_bloc.dart';

void main() {
  late OnTheAirTvshowBlocHelper onTheAirTvshowsBlocHelper;
  setUpAll(() {
    onTheAirTvshowsBlocHelper = OnTheAirTvshowBlocHelper();
    registerFallbackValue(OnTheAirTvshowStateHelper());
    registerFallbackValue(OnTheAirTvshowEventHelper());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<OnTheAirTvshowBloc>(
      create: (_) => onTheAirTvshowsBlocHelper,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  tearDown(() {
    onTheAirTvshowsBlocHelper.close();
  });

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => onTheAirTvshowsBlocHelper.state).thenReturn(TvshowLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(OntheairTvshowsPage()));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => onTheAirTvshowsBlocHelper.state).thenReturn(TvshowLoading());
    when(() => onTheAirTvshowsBlocHelper.state)
        .thenReturn(TvshowsHasData(testTvshowList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(OntheairTvshowsPage()));

    expect(listViewFinder, findsOneWidget);
  });
}
