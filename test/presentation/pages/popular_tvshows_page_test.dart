import 'package:ditonton/presentation/bloc/movie/movie_bloc.dart';
import 'package:ditonton/presentation/bloc/tvshow/tvshow_bloc.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/popular_tvshows_page.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper_tvhsow_bloc.dart';

void main() {
  late PopularTvshowBlocHelper popularTvshowsBlocHelper;
  setUpAll(() {
    popularTvshowsBlocHelper = PopularTvshowBlocHelper();
    registerFallbackValue(PopularTvshowStateHelper());
    registerFallbackValue(PopularTvshowEventHelper());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularTvshowBloc>(
      create: (_) => popularTvshowsBlocHelper,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  tearDown(() {
    popularTvshowsBlocHelper.close();
  });

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => popularTvshowsBlocHelper.state).thenReturn(TvshowLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(PopularTvshowsPage()));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => popularTvshowsBlocHelper.state).thenReturn(TvshowLoading());
    when(() => popularTvshowsBlocHelper.state)
        .thenReturn(TvshowsHasData(testTvshowList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(PopularTvshowsPage()));

    expect(listViewFinder, findsOneWidget);
  });
}
