import 'package:ditonton/data/models/created_by_model.dart';
import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/last_episode_to_air_model.dart';
import 'package:ditonton/data/models/networks_model.dart';
import 'package:ditonton/data/models/production_companies_model.dart';
import 'package:ditonton/data/models/production_countries_model.dart';
import 'package:ditonton/data/models/seasons_model.dart';
import 'package:ditonton/data/models/spoken_languages_model.dart';
import 'package:ditonton/data/models/tvshow_detail_model.dart';
import 'package:ditonton/domain/entities/created_by.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/last_episode_to_air.dart';
import 'package:ditonton/domain/entities/networks.dart';
import 'package:ditonton/domain/entities/production_companies.dart';
import 'package:ditonton/domain/entities/production_countries.dart';
import 'package:ditonton/domain/entities/seasons.dart';
import 'package:ditonton/domain/entities/spoken_languages.dart';
import 'package:ditonton/domain/entities/tvshow_detail.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvShowDetail = TvshowDetail(
    adult: false,
    backdropPath: 'backdropPath',
    createdBy: [
      CreatedBy(
        id: 1,
        creditId: 'creditId',
        name: 'name',
        gender: 1,
        profilePath: 'profilePath',
      ),
    ],
    episodeRunTime: const [1, 2, 3],
    firstAirDate: 'firstAirDate',
    genres: [Genre(id: 1, name: 'Action')],
    homepage: 'homepage',
    id: 1,
    inProduction: false,
    languages: const ['en'],
    lastAirDate: 'lastAirDate',
    lastEpisodeToAir: LastEpisodeToAir(
      id: 1,
      name: 'name',
      overview: 'overview',
      voteAverage: 1,
      voteCount: 1,
      airDate: 'airDate',
      episodeNumber: 1,
      episodeType: 'episodeType',
      productionCode: 'productionCode',
      runtime: 1,
      seasonNumber: 1,
      showId: 1,
      stillPath: 'stillPath',
    ),
    name: 'name',
    nextEpisodeToAir: LastEpisodeToAir(
      id: 1,
      name: 'name',
      overview: 'overview',
      voteAverage: 1,
      voteCount: 1,
      airDate: 'airDate',
      episodeNumber: 1,
      episodeType: 'episodeType',
      productionCode: 'productionCode',
      runtime: 1,
      seasonNumber: 1,
      showId: 1,
      stillPath: 'stillPath',
    ),
    networks: [
      Networks(
        id: 1,
        logoPath: 'logoPath',
        name: 'name',
        originCountry: 'originCountry',
      ),
    ],
    numberOfEpisodes: 1,
    numberOfSeasons: 1,
    originCountry: const ['en'],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1.0,
    posterPath: 'posterPath',
    productionCompanies: [
      ProductionCompanies(
        id: 1,
        logoPath: 'logoPath',
        name: 'name',
        originCountry: 'originCountry',
      ),
    ],
    productionCountries: [
      ProductionCountries(
        iso31661: 'iso31661',
        name: 'name',
      ),
    ],
    seasons: [
      Seasons(
        airDate: 'airDate',
        episodeCount: 1,
        id: 1,
        name: 'name',
        overview: 'overview',
        posterPath: 'posterPath',
        seasonNumber: 1,
        voteAverage: 1,
      ),
    ],
    spokenLanguages: [
      SpokenLanguages(
        englishName: 'englishName',
        iso6391: 'iso6391',
        name: 'name',
      ),
    ],
    status: 'status',
    tagline: 'tagline',
    type: 'type',
    voteAverage: 1.0,
    voteCount: 1,
  );

  final tTvShowDetailModel = TvshowDetailResponse(
    adult: false,
    backdropPath: 'backdropPath',
    createdBy: [
      CreatedByModel(
        id: 1,
        creditId: 'creditId',
        name: 'name',
        gender: 1,
        profilePath: 'profilePath',
      ),
    ],
    episodeRunTime: const [1, 2, 3],
    firstAirDate: 'firstAirDate',
    genres: [GenreModel(id: 1, name: 'Action')],
    homepage: 'homepage',
    id: 1,
    inProduction: false,
    languages: const ['en'],
    lastAirDate: 'lastAirDate',
    lastEpisodeToAir: LastEpisodeToAirModel(
      id: 1,
      name: 'name',
      overview: 'overview',
      voteAverage: 1,
      voteCount: 1,
      airDate: 'airDate',
      episodeNumber: 1,
      episodeType: 'episodeType',
      productionCode: 'productionCode',
      runtime: 1,
      seasonNumber: 1,
      showId: 1,
      stillPath: 'stillPath',
    ),
    name: 'name',
    nextEpisodeToAir: LastEpisodeToAirModel(
      id: 1,
      name: 'name',
      overview: 'overview',
      voteAverage: 1,
      voteCount: 1,
      airDate: 'airDate',
      episodeNumber: 1,
      episodeType: 'episodeType',
      productionCode: 'productionCode',
      runtime: 1,
      seasonNumber: 1,
      showId: 1,
      stillPath: 'stillPath',
    ),
    networks: [
      NetworksModel(
        id: 1,
        logoPath: 'logoPath',
        name: 'name',
        originCountry: 'originCountry',
      ),
    ],
    numberOfEpisodes: 1,
    numberOfSeasons: 1,
    originCountry: const ['en'],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1.0,
    posterPath: 'posterPath',
    productionCompanies: [
      ProductionCompaniesModel(
        id: 1,
        logoPath: 'logoPath',
        name: 'name',
        originCountry: 'originCountry',
      ),
    ],
    productionCountries: [
      ProductionCountriesModel(
        iso31661: 'iso31661',
        name: 'name',
      ),
    ],
    seasons: [
      SeasonsModel(
        airDate: 'airDate',
        episodeCount: 1,
        id: 1,
        name: 'name',
        overview: 'overview',
        posterPath: 'posterPath',
        seasonNumber: 1,
        voteAverage: 1,
      ),
    ],
    spokenLanguages: [
      SpokenLanguagesModel(
        englishName: 'englishName',
        iso6391: 'iso6391',
        name: 'name',
      ),
    ],
    status: 'status',
    tagline: 'tagline',
    type: 'type',
    voteAverage: 1.0,
    voteCount: 1,
  );

  group('TvShowDetail', () {
    test('supports value comparisons', () {
      expect(tTvShowDetail, tTvShowDetailModel.toEntity());
    });
  });
}
