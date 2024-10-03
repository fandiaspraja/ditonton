import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tvshow.dart';
import 'package:ditonton/presentation/pages/popular_tvshows_page.dart';
import 'package:ditonton/presentation/provider/popular_tvshow_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'popular_tvshows_page_test.mocks.dart';

@GenerateMocks([PopularTvshowNotifier])
void main() {
  late MockPopularTvshowNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockPopularTvshowNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<PopularTvshowNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockNotifier.popularTvshowsState).thenReturn(RequestState.Loading);

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(PopularTvshowsPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.popularTvshowsState).thenReturn(RequestState.Loaded);
    when(mockNotifier.popularTvshows).thenReturn(<Tvshow>[]);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(PopularTvshowsPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockNotifier.popularTvshowsState).thenReturn(RequestState.Error);
    when(mockNotifier.message).thenReturn('Error message');

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(PopularTvshowsPage()));

    expect(textFinder, findsOneWidget);
  });
}
