import 'package:ditonton/data/models/created_by_model.dart';
import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/last_episode_to_air_model.dart';
import 'package:ditonton/data/models/networks_model.dart';
import 'package:ditonton/data/models/production_companies_model.dart';
import 'package:ditonton/data/models/production_countries_model.dart';
import 'package:ditonton/data/models/seasons_model.dart';
import 'package:ditonton/data/models/spoken_languages_model.dart';
import 'package:ditonton/data/models/tvshow_detail_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  final tTvshowDetailResponseData = TvshowDetailResponse(
    adult: false,
    backdropPath: "/5S0SI4NjyMji05OPL0GOZ4BsiMh.jpg",
    createdBy: [
      CreatedByModel(
          id: 1,
          creditId: "creditid",
          name: "name",
          gender: 1,
          profilePath: "profilepath")
    ],
    episodeRunTime: [1, 2, 3],
    firstAirDate: "2020-01-20",
    genres: [GenreModel(id: 1, name: 'Action')],
    homepage: "homepage",
    id: 1,
    inProduction: false,
    languages: ["en"],
    lastAirDate: "2020-01-20",
    lastEpisodeToAir: testLastEpisodeToAirModel,
    name: "name",
    nextEpisodeToAir: testLastEpisodeToAirModel,
    networks: [
      NetworksModel(
          id: 1,
          logoPath: "/path.jpg",
          name: "name",
          originCountry: "originCountry")
    ],
    numberOfEpisodes: 1,
    numberOfSeasons: 1,
    originCountry: ["NL"],
    originalLanguage: "nl",
    originalName: 'Lang Leve de Liefde',
    overview: 'overview',
    popularity: 3416.968,
    posterPath: "/5S0SI4NjyMji05OPL0GOZ4BsiMh.jpg",
    productionCompanies: [
      ProductionCompaniesModel(
          id: 1,
          logoPath: "/path.jpg",
          name: "name",
          originCountry: "originCountry")
    ],
    productionCountries: [
      ProductionCountriesModel(iso31661: "iso", name: "name")
    ],
    seasons: [
      SeasonsModel(
          airDate: "airDate",
          episodeCount: 1,
          id: 1,
          name: "name",
          overview: "overview",
          posterPath: "posterPath",
          seasonNumber: 1,
          voteAverage: 1)
    ],
    spokenLanguages: [
      SpokenLanguagesModel(
          englishName: "englishName", iso6391: "iso", name: "name")
    ],
    status: "status",
    tagline: "tagline",
    type: "type",
    voteAverage: 6.3,
    voteCount: 6,
  );

  // final tTvshowDetail = testTvshowDetailResponse;

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap = {
        "adult": false,
        "backdrop_path": "/5S0SI4NjyMji05OPL0GOZ4BsiMh.jpg",
        "created_by": [
          {
            "id": 1,
            "credit_id": "creditid",
            "name": "name",
            "gender": 1,
            "profile_path": "profilepath"
          }
        ],
        "episode_run_time": [1, 2, 3],
        "first_air_date": "2020-01-20",
        "genres": [
          {"id": 1, "name": "Action"}
        ],
        "homepage": "homepage",
        "id": 1,
        "in_production": false,
        "languages": ["en"],
        "last_air_date": "2020-01-20",
        "last_episode_to_air": {
          "id": 1,
          "name": "name",
          "overview": "overview",
          "vote_average": 1,
          "vote_count": 1,
          "air_date": "airdate",
          "episode_number": 1,
          "production_code": "productioncode",
          "season_number": 1,
          "show_id": 1,
          "still_path": "stillpath"
        },
        "name": "name",
        "next_episode_to_air": {
          "id": 1,
          "name": "name",
          "overview": "overview",
          "vote_average": 1,
          "vote_count": 1,
          "air_date": "airdate",
          "episode_number": 1,
          "production_code": "productioncode",
          "season_number": 1,
          "show_id": 1,
          "still_path": "stillpath"
        },
        "networks": [
          {
            "id": 1,
            "logo_path": "/path.jpg",
            "name": "name",
            "origin_country": "originCountry"
          }
        ],
        "number_of_episodes": 1,
        "number_of_seasons": 1,
        "origin_country": ["NL"],
        "original_language": "nl",
        "original_name": "Lang Leve de Liefde",
        "overview": "overview",
        "popularity": 3416.968,
        "poster_path": "/5S0SI4NjyMji05OPL0GOZ4BsiMh.jpg",
        "production_companies": [
          {
            "id": 1,
            "logo_path": "/path.jpg",
            "name": "name",
            "origin_country": "originCountry"
          }
        ],
        "production_countries": [
          {"iso_3166_1": "iso", "name": "name"}
        ],
        "seasons": [
          {
            "air_date": "airDate",
            "episode_count": 1,
            "id": 1,
            "name": "name",
            "overview": "overview",
            "poster_path": "posterPath",
            "season_number": 1,
            "vote_average": 1
          }
        ],
        "spoken_languages": [
          {"english_name": "englishName", "iso_639_1": "iso", "name": "name"}
        ],
        "status": "status",
        "tagline": "tagline",
        "type": "type",
        "vote_average": 6.3,
        "vote_count": 6
      };
      // act
      final result = TvshowDetailResponse.fromJson(jsonMap);
      // assert
      expect(result.id, tTvshowDetailResponseData.id);
    });
  });

  test('should be a subclass of Tv Show Detail entity', () async {
    final result = tTvshowDetailResponseData.toEntity();
    expect(result, testTvshowDetailData);
  });
}
