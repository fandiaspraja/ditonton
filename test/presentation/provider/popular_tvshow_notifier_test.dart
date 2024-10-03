import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tvshow.dart';
import 'package:ditonton/domain/usecases/get_popular_tvshows.dart';
import 'package:ditonton/presentation/provider/popular_tvshow_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tvshow_list_notifier_test.mocks.dart';

@GenerateMocks([GetPopularTvshows])
void main() {
  late MockGetPopularTvshows mockGetPopularTvshows;
  late PopularTvshowNotifier provider;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetPopularTvshows = MockGetPopularTvshows();
    provider = PopularTvshowNotifier(getPopularTvshows: mockGetPopularTvshows)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  final tTvshow = Tvshow(
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

  final tTvshowList = <Tvshow>[tTvshow];

  group('popular tvshows', () {
    test('initialState should be Empty', () {
      expect(provider.popularTvshowsState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetPopularTvshows.execute())
          .thenAnswer((_) async => Right(tTvshowList));
      // act
      provider.fetchPopularTvshows();
      // assert
      verify(mockGetPopularTvshows.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetPopularTvshows.execute())
          .thenAnswer((_) async => Right(tTvshowList));
      // act
      provider.fetchPopularTvshows();
      // assert
      expect(provider.popularTvshowsState, RequestState.Loading);
    });

    test('should change tvshows when data is gotten successfully', () async {
      // arrange
      when(mockGetPopularTvshows.execute())
          .thenAnswer((_) async => Right(tTvshowList));
      // act
      await provider.fetchPopularTvshows();
      // assert
      expect(provider.popularTvshowsState, RequestState.Loaded);
      expect(provider.popularTvshows, tTvshowList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetPopularTvshows.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchPopularTvshows();
      // assert
      expect(provider.popularTvshowsState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
