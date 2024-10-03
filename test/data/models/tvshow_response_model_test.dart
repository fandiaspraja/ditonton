import 'dart:convert';

import 'package:ditonton/data/models/movie_model.dart';
import 'package:ditonton/data/models/movie_response.dart';
import 'package:ditonton/data/models/tvshow_model.dart';
import 'package:ditonton/data/models/tvshow_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tTvshowModel = TvshowModel(
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

  final tTvshowResponseModel =
      TvshowResponse(tvshowList: <TvshowModel>[tTvshowModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/airing_today_tvshow.json'));
      // act
      final result = TvshowResponse.fromJson(jsonMap);

      print("$result");
      // assert
      expect(result, tTvshowResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvshowResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "adult": false,
            "backdrop_path": "/5S0SI4NjyMji05OPL0GOZ4BsiMh.jpg",
            "genre_ids": [1, 2, 3],
            "id": 136166,
            "origin_country": ["NL"],
            "original_language": "nl",
            "original_name": "Lang Leve de Liefde",
            "overview": "overview",
            "popularity": 3416.968,
            "poster_path": "/9lpvvzEl5kViIc2vUJG4QKzj2ds.jpg",
            "first_air_date": "2020-01-20",
            "name": "Lang Leve de Liefde",
            "vote_average": 6.3,
            "vote_count": 6
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
