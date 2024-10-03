import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tvshow.dart';
import 'package:ditonton/domain/usecases/get_airing_today_tvshows.dart';
import 'package:ditonton/domain/usecases/get_ontheair_tvshows.dart';
import 'package:ditonton/domain/usecases/get_popular_tvshows.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tvshows.dart';
import 'package:ditonton/presentation/provider/tvshow_list_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tvshow_list_notifier_test.mocks.dart';

@GenerateMocks([
  GetAiringTodayTvshows,
  GetOntheairTvshows,
  GetPopularTvshows,
  GetTopRatedTvshows
])
void main() {
  late TvshowListNotifier provider;
  late MockGetAiringTodayTvshows mockGetAiringTodayTvshows;
  late MockGetOntheairTvshows mockGetOntheairTvshows;
  late MockGetPopularTvshows mockGetPopularTvshows;
  late MockGetTopRatedTvshows mockGetTopRatedTvshows;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetAiringTodayTvshows = MockGetAiringTodayTvshows();
    mockGetOntheairTvshows = MockGetOntheairTvshows();
    mockGetPopularTvshows = MockGetPopularTvshows();
    mockGetTopRatedTvshows = MockGetTopRatedTvshows();
    provider = TvshowListNotifier(
      getAiringTodayTvshows: mockGetAiringTodayTvshows,
      getOntheairTvshows: mockGetOntheairTvshows,
      getPopularTvshows: mockGetPopularTvshows,
      getTopRatedTvshows: mockGetTopRatedTvshows,
    )..addListener(() {
        listenerCallCount += 1;
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

  group('airing today tvshows', () {
    test('initialState should be Empty', () {
      expect(provider.airingTodayTvshowsState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetAiringTodayTvshows.execute())
          .thenAnswer((_) async => Right(tTvshowList));
      // act
      provider.fetchAiringTodayTvshows();
      // assert
      verify(mockGetAiringTodayTvshows.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetAiringTodayTvshows.execute())
          .thenAnswer((_) async => Right(tTvshowList));
      // act
      provider.fetchAiringTodayTvshows();
      // assert
      expect(provider.airingTodayTvshowsState, RequestState.Loading);
    });

    test('should change tvshows when data is gotten successfully', () async {
      // arrange
      when(mockGetAiringTodayTvshows.execute())
          .thenAnswer((_) async => Right(tTvshowList));
      // act
      await provider.fetchAiringTodayTvshows();
      // assert
      expect(provider.airingTodayTvshowsState, RequestState.Loaded);
      expect(provider.airingTodayTvshows, tTvshowList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetAiringTodayTvshows.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchAiringTodayTvshows();
      // assert
      expect(provider.airingTodayTvshowsState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('on the air tvshows', () {
    test('initialState should be Empty', () {
      expect(provider.onTheAirTvshowsState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetOntheairTvshows.execute())
          .thenAnswer((_) async => Right(tTvshowList));
      // act
      provider.fetchOntheairTvshows();
      // assert
      verify(mockGetOntheairTvshows.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetOntheairTvshows.execute())
          .thenAnswer((_) async => Right(tTvshowList));
      // act
      provider.fetchOntheairTvshows();
      // assert
      expect(provider.onTheAirTvshowsState, RequestState.Loading);
    });

    test('should change tvshows when data is gotten successfully', () async {
      // arrange
      when(mockGetOntheairTvshows.execute())
          .thenAnswer((_) async => Right(tTvshowList));
      // act
      await provider.fetchOntheairTvshows();
      // assert
      expect(provider.onTheAirTvshowsState, RequestState.Loaded);
      expect(provider.onTheAirTvshows, tTvshowList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetOntheairTvshows.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchOntheairTvshows();
      // assert
      expect(provider.onTheAirTvshowsState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

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

  group('Top Rated tvshows', () {
    test('initialState should be Empty', () {
      expect(provider.topRatedTvshowsState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetTopRatedTvshows.execute())
          .thenAnswer((_) async => Right(tTvshowList));
      // act
      provider.fetchTopRatedTvshows();
      // assert
      verify(mockGetTopRatedTvshows.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetTopRatedTvshows.execute())
          .thenAnswer((_) async => Right(tTvshowList));
      // act
      provider.fetchTopRatedTvshows();
      // assert
      expect(provider.topRatedTvshowsState, RequestState.Loading);
    });

    test('should change tvshows when data is gotten successfully', () async {
      // arrange
      when(mockGetTopRatedTvshows.execute())
          .thenAnswer((_) async => Right(tTvshowList));
      // act
      await provider.fetchTopRatedTvshows();
      // assert
      expect(provider.topRatedTvshowsState, RequestState.Loaded);
      expect(provider.topRatedTvshows, tTvshowList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTopRatedTvshows.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTopRatedTvshows();
      // assert
      expect(provider.topRatedTvshowsState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
