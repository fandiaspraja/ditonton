import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tvshow.dart';
import 'package:ditonton/presentation/pages/top_rated_tvshows_page.dart';
import 'package:ditonton/presentation/provider/top_rated_tvshow_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'top_rated_tvshow_page_test.mocks.dart';

@GenerateMocks([TopRatedTvshowNotifier])
void main() {
  late MockTopRatedTvshowNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockTopRatedTvshowNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TopRatedTvshowNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockNotifier.topRatedTvshowsState).thenReturn(RequestState.Loading);

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TopRatedTvshowsPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.topRatedTvshowsState).thenReturn(RequestState.Loaded);
    when(mockNotifier.topRatedTvshows).thenReturn(<Tvshow>[]);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TopRatedTvshowsPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockNotifier.topRatedTvshowsState).thenReturn(RequestState.Error);
    when(mockNotifier.message).thenReturn('Error message');

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(TopRatedTvshowsPage()));

    expect(textFinder, findsOneWidget);
  });
}
