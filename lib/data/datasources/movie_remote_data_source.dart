import 'dart:convert';
import 'dart:io';

import 'package:ditonton/data/models/movie_detail_model.dart';
import 'package:ditonton/data/models/movie_model.dart';
import 'package:ditonton/data/models/movie_response.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/models/tvshow_detail_model.dart';
import 'package:ditonton/data/models/tvshow_model.dart';
import 'package:ditonton/data/models/tvshow_response.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getNowPlayingMovies();
  Future<List<TvshowModel>> getTvshowAiringTodays();
  Future<List<TvshowModel>> getTvshowOntheAir();
  Future<List<TvshowModel>> getTvshowPopular();
  Future<List<TvshowModel>> getTvshowTopRated();
  Future<List<TvshowModel>> searchTvshows(String query);
  Future<TvshowDetailResponse> getTvshowDetail(int id);
  Future<List<TvshowModel>> getTvshowRecommendations(int id);

  Future<List<MovieModel>> getPopularMovies();
  Future<List<MovieModel>> getTopRatedMovies();
  Future<MovieDetailResponse> getMovieDetail(int id);
  Future<List<MovieModel>> getMovieRecommendations(int id);
  Future<List<MovieModel>> searchMovies(String query);
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  static const API_KEY = 'api_key=c10e511a466446ab857c3af67c1e2734';
  static const BASE_URL = 'https://api.themoviedb.org/3';

  final IOClient client;

  MovieRemoteDataSourceImpl({required this.client});

  @override
  Future<List<MovieModel>> getNowPlayingMovies() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/movie/now_playing?$API_KEY'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<MovieDetailResponse> getMovieDetail(int id) async {
    final response =
        await client.get(Uri.parse('$BASE_URL/movie/$id?$API_KEY'));

    if (response.statusCode == 200) {
      return MovieDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getMovieRecommendations(int id) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/movie/$id/recommendations?$API_KEY'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/movie/popular?$API_KEY'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getTopRatedMovies() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/movie/top_rated?$API_KEY'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> searchMovies(String query) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/search/movie?$API_KEY&query=$query'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvshowModel>> getTvshowAiringTodays() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY'));

    if (response.statusCode == 200) {
      return TvshowResponse.fromJson(json.decode(response.body)).tvshowList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvshowModel>> getTvshowOntheAir() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY'));

    if (response.statusCode == 200) {
      return TvshowResponse.fromJson(json.decode(response.body)).tvshowList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvshowModel>> getTvshowPopular() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY'));

    if (response.statusCode == 200) {
      return TvshowResponse.fromJson(json.decode(response.body)).tvshowList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvshowModel>> getTvshowTopRated() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY'));

    if (response.statusCode == 200) {
      return TvshowResponse.fromJson(json.decode(response.body)).tvshowList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvshowModel>> searchTvshows(String query) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query'));

    if (response.statusCode == 200) {
      return TvshowResponse.fromJson(json.decode(response.body)).tvshowList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TvshowDetailResponse> getTvshowDetail(int id) async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/$id?$API_KEY'));

    if (response.statusCode == 200) {
      return TvshowDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvshowModel>> getTvshowRecommendations(int id) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/tv/$id/recommendations?$API_KEY'));

    if (response.statusCode == 200) {
      return TvshowResponse.fromJson(json.decode(response.body)).tvshowList;
    } else {
      throw ServerException();
    }
  }

  // Future<http.Response> _sslGet(Uri url) async {
  //   // 1. Load Certificate from Assets
  //   ByteData data = await rootBundle.load('certificates/certificates.pem');
  //   SecurityContext securityContext = SecurityContext.defaultContext;
  //   securityContext.setTrustedCertificatesBytes(data.buffer.asUint8List());

  //   // 2. Create HttpClient with Custom Security Context
  //   HttpClient client = HttpClient(context: securityContext);
  //   client.badCertificateCallback =
  //       (X509Certificate cert, String host, int port) => false;

  //   // 3. Configure HTTP Client for HTTPS
  //   io.IOClient ioClient = io.IOClient(client);

  //   // 4. Make the Request
  //   return await ioClient.get(url, headers: {
  //     HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
  //   });
  // }
}
