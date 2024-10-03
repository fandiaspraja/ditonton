import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tvshow.dart';
import 'package:ditonton/domain/usecases/get_tvshow_detail.dart';
import 'package:ditonton/domain/usecases/get_tvshow_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status_tvshow.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tvshow.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tvshow.dart';
import 'package:ditonton/presentation/provider/tvshow_detail_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tvshow_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetTvshowDetail,
  GetTvshowRecommendations,
  GetWatchListStatusTvshow,
  SaveWatchlistTvshow,
  RemoveWatchlistTvshow,
])
void main() {
  late TvshowDetailNotifier provider;
  late MockGetTvshowDetail mockGetTvshowDetail;
  late MockGetTvshowRecommendations mockGetTvshowRecommendations;
  late MockGetWatchListStatusTvshow mockGetWatchlistStatusTvshow;
  late MockSaveWatchlistTvshow mockSaveWatchlistTvshow;
  late MockRemoveWatchlistTvshow mockRemoveWatchlistTvshow;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvshowDetail = MockGetTvshowDetail();
    mockGetTvshowRecommendations = MockGetTvshowRecommendations();
    mockGetWatchlistStatusTvshow = MockGetWatchListStatusTvshow();
    mockSaveWatchlistTvshow = MockSaveWatchlistTvshow();
    mockRemoveWatchlistTvshow = MockRemoveWatchlistTvshow();
    provider = TvshowDetailNotifier(
      getTvshowDetail: mockGetTvshowDetail,
      getTvshowRecommendations: mockGetTvshowRecommendations,
      getWatchListStatus: mockGetWatchlistStatusTvshow,
      saveWatchlist: mockSaveWatchlistTvshow,
      removeWatchlist: mockRemoveWatchlistTvshow,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tId = 1;

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

  final tTvshows = <Tvshow>[tTvshow];

  void _arrangeUsecase() {
    when(mockGetTvshowDetail.execute(tId))
        .thenAnswer((_) async => Right(testTvshowDetail));
    when(mockGetTvshowRecommendations.execute(tId))
        .thenAnswer((_) async => Right(tTvshows));
  }

  group('Get Tvshow Detail', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvshowDetail(tId);
      // assert
      verify(mockGetTvshowDetail.execute(tId));
      verify(mockGetTvshowRecommendations.execute(tId));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      _arrangeUsecase();
      // act
      provider.fetchTvshowDetail(tId);
      // assert
      expect(provider.tvshowState, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should change tvshow when data is gotten successfully', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvshowDetail(tId);
      // assert
      expect(provider.tvshowState, RequestState.Loaded);
      expect(provider.tvshow, testTvshowDetail);
      expect(listenerCallCount, 3);
    });

    test(
        'should change recommendation tvshows when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvshowDetail(tId);
      // assert
      expect(provider.tvshowState, RequestState.Loaded);
      expect(provider.tvshowRecommendations, tTvshows);
    });
  });

  group('Get Tvshow Recommendations', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvshowDetail(tId);
      // assert
      verify(mockGetTvshowRecommendations.execute(tId));
      expect(provider.tvshowRecommendations, tTvshows);
    });

    test('should update recommendation state when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvshowDetail(tId);
      // assert
      expect(provider.recommendationState, RequestState.Loaded);
      expect(provider.tvshowRecommendations, tTvshows);
    });

    test('should update error message when request in successful', () async {
      // arrange
      when(mockGetTvshowDetail.execute(tId))
          .thenAnswer((_) async => Right(testTvshowDetail));
      when(mockGetTvshowRecommendations.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Failed')));
      // act
      await provider.fetchTvshowDetail(tId);
      // assert
      expect(provider.recommendationState, RequestState.Error);
      expect(provider.message, 'Failed');
    });
  });

  group('Watchlist', () {
    test('should get the watchlist status', () async {
      // arrange
      when(mockGetWatchlistStatusTvshow.execute(1))
          .thenAnswer((_) async => true);
      // act
      await provider.loadWatchlistStatus(1);
      // assert
      expect(provider.isAddedToWatchlist, true);
    });

    test('should execute save watchlist when function called', () async {
      // arrange
      when(mockSaveWatchlistTvshow.execute(testTvshowDetail))
          .thenAnswer((_) async => Right('Success'));
      when(mockGetWatchlistStatusTvshow.execute(testTvshowDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testTvshowDetail);
      // assert
      verify(mockSaveWatchlistTvshow.execute(testTvshowDetail));
    });

    test('should execute remove watchlist when function called', () async {
      // arrange
      when(mockRemoveWatchlistTvshow.execute(testTvshowDetail))
          .thenAnswer((_) async => Right('Removed'));
      when(mockGetWatchlistStatusTvshow.execute(testTvshowDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.removeFromWatchlist(testTvshowDetail);
      // assert
      verify(mockRemoveWatchlistTvshow.execute(testTvshowDetail));
    });

    test('should update watchlist status when add watchlist success', () async {
      // arrange
      when(mockSaveWatchlistTvshow.execute(testTvshowDetail))
          .thenAnswer((_) async => Right('Added to Watchlist'));
      when(mockGetWatchlistStatusTvshow.execute(testTvshowDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testTvshowDetail);
      // assert
      verify(mockGetWatchlistStatusTvshow.execute(testTvshowDetail.id));
      expect(provider.isAddedToWatchlist, true);
      expect(provider.watchlistMessage, 'Added to Watchlist');
      expect(listenerCallCount, 1);
    });

    test('should update watchlist message when add watchlist failed', () async {
      // arrange
      when(mockSaveWatchlistTvshow.execute(testTvshowDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockGetWatchlistStatusTvshow.execute(testTvshowDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.addWatchlist(testTvshowDetail);
      // assert
      expect(provider.watchlistMessage, 'Failed');
      expect(listenerCallCount, 1);
    });
  });

  group('on Error', () {
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTvshowDetail.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      when(mockGetTvshowRecommendations.execute(tId))
          .thenAnswer((_) async => Right(tTvshows));
      // act
      await provider.fetchTvshowDetail(tId);
      // assert
      expect(provider.tvshowState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
