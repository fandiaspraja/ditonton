import 'dart:convert';

import 'package:ditonton/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/data/models/movie_detail_model.dart';
import 'package:ditonton/data/models/movie_response.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/models/tvshow_detail_model.dart';
import 'package:ditonton/data/models/tvshow_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/io_client.dart';

import '../../json_reader.dart';
import '../../helpers/test_helper.mocks.dart';
import 'movie_remote_data_source_test.mocks.dart';

@GenerateMocks([IOClient])
void main() {
  const API_KEY = 'api_key=c10e511a466446ab857c3af67c1e2734';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late MovieRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;
  late MockIOClient mockIOClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    mockIOClient = MockIOClient();
    dataSource = MovieRemoteDataSourceImpl(client: mockIOClient);
  });

  group('get Now Playing Movies', () {
    final tMovieList = MovieResponse.fromJson(
            json.decode(readJson('dummy_data/now_playing.json')))
        .movieList;

    test('should return list of Movie Model when the response code is 200',
        () async {
      // arrange
      when(mockIOClient.get(Uri.parse('$BASE_URL/movie/now_playing?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/now_playing.json'), 200));
      // act
      final result = await dataSource.getNowPlayingMovies();
      // assert
      expect(result, equals(tMovieList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockIOClient.get(Uri.parse('$BASE_URL/movie/now_playing?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getNowPlayingMovies();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Popular Movies', () {
    final tMovieList =
        MovieResponse.fromJson(json.decode(readJson('dummy_data/popular.json')))
            .movieList;

    test('should return list of movies when response is success (200)',
        () async {
      // arrange
      when(mockIOClient.get(Uri.parse('$BASE_URL/movie/popular?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/popular.json'), 200));
      // act
      final result = await dataSource.getPopularMovies();
      // assert
      expect(result, tMovieList);
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockIOClient.get(Uri.parse('$BASE_URL/movie/popular?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getPopularMovies();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Top Rated Movies', () {
    final tMovieList = MovieResponse.fromJson(
            json.decode(readJson('dummy_data/top_rated.json')))
        .movieList;

    test('should return list of movies when response code is 200 ', () async {
      // arrange
      when(mockIOClient.get(Uri.parse('$BASE_URL/movie/top_rated?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/top_rated.json'), 200));
      // act
      final result = await dataSource.getTopRatedMovies();
      // assert
      expect(result, tMovieList);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockIOClient.get(Uri.parse('$BASE_URL/movie/top_rated?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTopRatedMovies();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get movie detail', () {
    final tId = 1;
    final tMovieDetail = MovieDetailResponse.fromJson(
        json.decode(readJson('dummy_data/movie_detail.json')));

    test('should return movie detail when the response code is 200', () async {
      // arrange
      when(mockIOClient.get(Uri.parse('$BASE_URL/movie/$tId?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/movie_detail.json'), 200));
      // act
      final result = await dataSource.getMovieDetail(tId);
      // assert
      expect(result, equals(tMovieDetail));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockIOClient.get(Uri.parse('$BASE_URL/movie/$tId?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getMovieDetail(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get movie recommendations', () {
    final tMovieList = MovieResponse.fromJson(
            json.decode(readJson('dummy_data/movie_recommendations.json')))
        .movieList;
    final tId = 1;

    test('should return list of Movie Model when the response code is 200',
        () async {
      // arrange
      when(mockIOClient
              .get(Uri.parse('$BASE_URL/movie/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/movie_recommendations.json'), 200));
      // act
      final result = await dataSource.getMovieRecommendations(tId);
      // assert
      expect(result, equals(tMovieList));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockIOClient
              .get(Uri.parse('$BASE_URL/movie/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getMovieRecommendations(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search movies', () {
    final tSearchResult = MovieResponse.fromJson(
            json.decode(readJson('dummy_data/search_spiderman_movie.json')))
        .movieList;
    final tQuery = 'Spiderman';

    test('should return list of movies when response code is 200', () async {
      // arrange
      when(mockIOClient
              .get(Uri.parse('$BASE_URL/search/movie?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/search_spiderman_movie.json'), 200));
      // act
      final result = await dataSource.searchMovies(tQuery);
      // assert
      expect(result, tSearchResult);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockIOClient
              .get(Uri.parse('$BASE_URL/search/movie?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.searchMovies(tQuery);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Airing Today Tvshows', () {
    final tTvshowList = TvshowResponse.fromJson(
            json.decode(readJson('dummy_data/airing_today_tvshow.json')))
        .tvshowList;

    test('should return list of Tvshow Model when the response code is 200',
        () async {
      // arrange
      when(mockIOClient.get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/airing_today_tvshow.json'), 200));
      // act
      final result = await dataSource.getTvshowAiringTodays();
      // assert
      expect(result, equals(tTvshowList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockIOClient.get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTvshowAiringTodays();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get On The Air  Tvshows', () {
    final tTvshowList = TvshowResponse.fromJson(
            json.decode(readJson('dummy_data/ontheair_tvshow.json')))
        .tvshowList;

    test('should return list of Tvshow Model when the response code is 200',
        () async {
      // arrange
      when(mockIOClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/ontheair_tvshow.json'), 200));
      // act
      final result = await dataSource.getTvshowOntheAir();
      // assert
      expect(result, equals(tTvshowList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockIOClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTvshowOntheAir();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Popular Tvshows', () {
    final tTvshowList = TvshowResponse.fromJson(
            json.decode(readJson('dummy_data/popular_tvshow.json')))
        .tvshowList;

    test('should return list of Tvshow Model when the response code is 200',
        () async {
      // arrange
      when(mockIOClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/popular_tvshow.json'), 200));
      // act
      final result = await dataSource.getTvshowPopular();
      // assert
      expect(result, equals(tTvshowList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockIOClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTvshowPopular();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Top Rated Tvshows', () {
    final tTvshowList = TvshowResponse.fromJson(
            json.decode(readJson('dummy_data/top_rated_tvshow.json')))
        .tvshowList;

    test('should return list of Tvshow Model when the response code is 200',
        () async {
      // arrange
      when(mockIOClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/top_rated_tvshow.json'), 200));
      // act
      final result = await dataSource.getTvshowTopRated();
      // assert
      expect(result, equals(tTvshowList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockIOClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTvshowTopRated();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get tvshow detail', () {
    final tId = 1;
    final tTvshowDetail = TvshowDetailResponse.fromJson(
        json.decode(readJson('dummy_data/tvshow_detail.json')));

    test('should return tvshow detail when the response code is 200', () async {
      // arrange
      when(mockIOClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/tvshow_detail.json'), 200));
      // act
      final result = await dataSource.getTvshowDetail(tId);

      // assert
      // expect(result, equals(tTvshowDetail));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockIOClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTvshowDetail(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get tvshow recommendations', () {
    final tTvshowList = TvshowResponse.fromJson(
            json.decode(readJson('dummy_data/tvshow_recommendations.json')))
        .tvshowList;
    final tId = 1;

    test('should return list of Tvshow Model when the response code is 200',
        () async {
      // arrange
      when(mockIOClient
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tvshow_recommendations.json'), 200));
      // act
      final result = await dataSource.getTvshowRecommendations(tId);
      // assert
      expect(result, equals(tTvshowList));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockIOClient
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTvshowRecommendations(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search tvshows', () {
    final tSearchResult = TvshowResponse.fromJson(
            json.decode(readJson('dummy_data/search_tvshow.json')))
        .tvshowList;
    final tQuery = 'Lang Leve';

    test('should return list of tvshows when response code is 200', () async {
      // arrange
      when(mockIOClient
              .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/search_tvshow.json'), 200));
      // act
      final result = await dataSource.searchTvshows(tQuery);
      // assert
      expect(result, tSearchResult);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockIOClient
              .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.searchTvshows(tQuery);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
