import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/tvshow_detail_model.dart';
import 'package:ditonton/data/models/tvshow_model.dart';
import 'package:ditonton/data/repositories/tvshow_repository_impl.dart';
import 'package:ditonton/domain/entities/tvshow.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvshowRepositoryImpl repository;
  late MockMovieRemoteDataSource mockRemoteDataSource;
  late MockMovieLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockMovieRemoteDataSource();
    mockLocalDataSource = MockMovieLocalDataSource();
    repository = TvshowRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  final tTvshowModel = TvshowModel(
      adult: false,
      backdropPath: "/5S0SI4NjyMji05OPL0GOZ4BsiMh.jpg",
      genreIds: [1, 2, 3],
      id: 1,
      originCountry: ["NL"],
      originalLanguage: "nl",
      originalName: 'Lang Leve de Liefde',
      overview: 'overview',
      popularity: 3416.968,
      posterPath: "/5S0SI4NjyMji05OPL0GOZ4BsiMh.jpg",
      firstAirDate: "2020-01-20",
      name: "Lang Leve de Liefde",
      voteAverage: 6.3,
      voteCount: 6);

  final tTvshow = Tvshow(
      adult: false,
      backdropPath: "/5S0SI4NjyMji05OPL0GOZ4BsiMh.jpg",
      genreIds: [1, 2, 3],
      id: 1,
      originCountry: ["NL"],
      originalLanguage: "nl",
      originalName: 'Lang Leve de Liefde',
      overview: 'overview',
      popularity: 3416.968,
      posterPath: "/5S0SI4NjyMji05OPL0GOZ4BsiMh.jpg",
      firstAirDate: "2020-01-20",
      name: "Lang Leve de Liefde",
      voteAverage: 6.3,
      voteCount: 6);

  final tTvshowModelList = <TvshowModel>[tTvshowModel];
  final tTvshowList = <Tvshow>[tTvshow];

  group('Airing Today Tvshows', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvshowAiringTodays())
          .thenAnswer((_) async => tTvshowModelList);
      // act
      final result = await repository.getTvshowAiringTodays();
      // assert
      verify(mockRemoteDataSource.getTvshowAiringTodays());
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvshowList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvshowAiringTodays())
          .thenThrow(ServerException());
      // act
      final result = await repository.getTvshowAiringTodays();
      // assert
      verify(mockRemoteDataSource.getTvshowAiringTodays());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvshowAiringTodays())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvshowAiringTodays();
      // assert
      verify(mockRemoteDataSource.getTvshowAiringTodays());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('On The Air Tvshows', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvshowOntheAir())
          .thenAnswer((_) async => tTvshowModelList);
      // act
      final result = await repository.getTvshowOntheAir();
      // assert
      verify(mockRemoteDataSource.getTvshowOntheAir());
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvshowList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvshowOntheAir())
          .thenThrow(ServerException());
      // act
      final result = await repository.getTvshowOntheAir();
      // assert
      verify(mockRemoteDataSource.getTvshowOntheAir());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvshowOntheAir())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvshowOntheAir();
      // assert
      verify(mockRemoteDataSource.getTvshowOntheAir());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Popular Tvshows', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvshowPopular())
          .thenAnswer((_) async => tTvshowModelList);
      // act
      final result = await repository.getTvshowPopular();
      // assert
      verify(mockRemoteDataSource.getTvshowPopular());
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvshowList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvshowPopular())
          .thenThrow(ServerException());
      // act
      final result = await repository.getTvshowPopular();
      // assert
      verify(mockRemoteDataSource.getTvshowPopular());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvshowPopular())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvshowPopular();
      // assert
      verify(mockRemoteDataSource.getTvshowPopular());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Top Rated Tvshows', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvshowTopRated())
          .thenAnswer((_) async => tTvshowModelList);
      // act
      final result = await repository.getTvshowTopRated();
      // assert
      verify(mockRemoteDataSource.getTvshowTopRated());
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvshowList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvshowTopRated())
          .thenThrow(ServerException());
      // act
      final result = await repository.getTvshowTopRated();
      // assert
      verify(mockRemoteDataSource.getTvshowTopRated());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvshowTopRated())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvshowTopRated();
      // assert
      verify(mockRemoteDataSource.getTvshowTopRated());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get Tvshow Detail', () {
    final tId = 1;
    final tTvshowResponse = TvshowDetailResponse(
      adult: false,
      backdropPath: "/5S0SI4NjyMji05OPL0GOZ4BsiMh.jpg",
      genres: [GenreModel(id: 1, name: 'Action')],
      id: 1,
      originCountry: ["NL"],
      originalLanguage: "nl",
      originalName: 'Lang Leve de Liefde',
      overview: 'overview',
      popularity: 3416.968,
      posterPath: "/5S0SI4NjyMji05OPL0GOZ4BsiMh.jpg",
      firstAirDate: "2020-01-20",
      name: "Lang Leve de Liefde",
      voteAverage: 6.3,
      voteCount: 6,
    );

    test(
        'should return Tvshow data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvshowDetail(tId))
          .thenAnswer((_) async => tTvshowResponse);
      // act
      final result = await repository.getTvshowDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTvshowDetail(tId));
      expect(result, equals(Right(testTvshowDetail)));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvshowDetail(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTvshowDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTvshowDetail(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvshowDetail(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvshowDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTvshowDetail(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get Tvshow Recommendations', () {
    final tTvshowList = <TvshowModel>[];
    final tId = 1;

    test('should return data (movie list) when the call is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvshowRecommendations(tId))
          .thenAnswer((_) async => tTvshowList);
      // act
      final result = await repository.getTvshowRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getTvshowRecommendations(tId));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tTvshowList));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvshowRecommendations(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTvshowRecommendations(tId);
      // assertbuild runner
      verify(mockRemoteDataSource.getTvshowRecommendations(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvshowRecommendations(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvshowRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getTvshowRecommendations(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Seach Tvshows', () {
    final tQuery = 'Lang Leve';

    test('should return tvshow list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTvshows(tQuery))
          .thenAnswer((_) async => tTvshowModelList);
      // act
      final result = await repository.searchTvshows(tQuery);
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvshowList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTvshows(tQuery))
          .thenThrow(ServerException());
      // act
      final result = await repository.searchTvshows(tQuery);
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTvshows(tQuery))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.searchTvshows(tQuery);
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlist(testMovieTableTvshow))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.removeWatchlist(testTvshowDetail);
      // assert
      expect(result, Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlist(testMovieTableTvshow))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeWatchlist(testTvshowDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      final tId = 1;
      when(mockLocalDataSource.getMovieById(tId)).thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchlist(tId);
      // assert
      expect(result, false);
    });
  });

  group('get watchlist tvshow', () {
    test('should return list of Movies', () async {
      // arrange
      when(mockLocalDataSource.getWatchlistMovies())
          .thenAnswer((_) async => [testMovieTableTvshow]);
      // act
      final result = await repository.getWatchlistTvshows();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistTvshow]);
    });
  });
}
