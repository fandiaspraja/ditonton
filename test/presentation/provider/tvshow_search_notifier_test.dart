import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tvshow.dart';
import 'package:ditonton/domain/usecases/search_tvshows.dart';
import 'package:ditonton/presentation/provider/tvshow_search_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tvshow_search_notifier_test.mocks.dart';

@GenerateMocks([SearchTvshows])
void main() {
  late TvshowSearchNotifier provider;
  late MockSearchTvshows mockSearchTvshows;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockSearchTvshows = MockSearchTvshows();
    provider = TvshowSearchNotifier(searchTvshows: mockSearchTvshows)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tTvshowModel = Tvshow(
      adult: false,
      backdropPath: "/5S0SI4NjyMji05OPL0GOZ4BsiMh.jpg",
      genreIds: [1, 2, 3],
      id: 136166,
      originCountry: ["NL"],
      originalLanguage: "nl",
      originalName: 'Lang Leve de Liefde',
      overview: 'overview',
      popularity: 3416.968,
      posterPath: "/9lpvvzEl5kViIc2vUJG4QKzj2ds.jpg",
      firstAirDate: "2020-01-20",
      name: "Lang Leve de Liefde",
      voteAverage: 6.3,
      voteCount: 6);

  final tTvshowList = <Tvshow>[tTvshowModel];
  final tQuery = 'Lang Leve';

  group('search tvshows', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockSearchTvshows.execute(tQuery))
          .thenAnswer((_) async => Right(tTvshowList));
      // act
      provider.fetchTvshowSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Loading);
    });

    test('should change search result data when data is gotten successfully',
        () async {
      // arrange
      when(mockSearchTvshows.execute(tQuery))
          .thenAnswer((_) async => Right(tTvshowList));
      // act
      await provider.fetchTvshowSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Loaded);
      expect(provider.searchResult, tTvshowList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockSearchTvshows.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTvshowSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
