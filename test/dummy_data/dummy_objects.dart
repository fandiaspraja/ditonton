import 'package:ditonton/data/models/created_by_model.dart';
import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/last_episode_to_air_model.dart';
import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/data/models/networks_model.dart';
import 'package:ditonton/data/models/production_companies_model.dart';
import 'package:ditonton/data/models/production_countries_model.dart';
import 'package:ditonton/data/models/seasons_model.dart';
import 'package:ditonton/data/models/spoken_languages_model.dart';
import 'package:ditonton/data/models/tvshow_detail_model.dart';
import 'package:ditonton/domain/entities/created_by.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/last_episode_to_air.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/networks.dart';
import 'package:ditonton/domain/entities/production_companies.dart';
import 'package:ditonton/domain/entities/production_countries.dart';
import 'package:ditonton/domain/entities/seasons.dart';
import 'package:ditonton/domain/entities/spoken_languages.dart';
import 'package:ditonton/domain/entities/tvshow.dart';
import 'package:ditonton/domain/entities/tvshow_detail.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
  type: "movie",
);

final testTvshow = Tvshow(
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

final testMovieList = [testMovie];

final testTvshowList = [testTvshow];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testTvshowDetail = TvshowDetail(
  adult: false,
  backdropPath: "/5S0SI4NjyMji05OPL0GOZ4BsiMh.jpg",
  genres: [Genre(id: 1, name: 'Action')],
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

final testProductionCompanies = ProductionCompanies(
  id: 1,
  logoPath: "/path.jpg",
  name: "name",
  originCountry: "originCountry",
);

final testProductionCountries = ProductionCountries(
  iso31661: "iso",
  name: "name",
);

final testSpokenLanguages = SpokenLanguages(
  englishName: "englishName",
  iso6391: "iso",
  name: "name",
);

final testSeasons = Seasons(
  airDate: "airDate",
  episodeCount: 1,
  id: 1,
  name: "name",
  overview: "overview",
  posterPath: "posterPath",
  seasonNumber: 1,
  voteAverage: 1,
);

final testNetworks = Networks(
  id: 1,
  logoPath: "/path.jpg",
  name: "name",
  originCountry: "originCountry",
);

final testMovieDetailModel = MovieDetail(
  adult: true,
  backdropPath: "backdropPath",
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: "originalTitle",
  overview: "overview",
  posterPath: "posterPath",
  releaseDate: "releaseDate",
  runtime: 1,
  title: "title",
  voteAverage: 5.0,
  voteCount: 5,
);

final testCreatedBy = CreatedBy(
    id: 1,
    creditId: "creditid",
    name: "name",
    gender: 1,
    profilePath: "profilepath");

final testGenre = Genre(
  id: 1,
  name: "name",
);

final testLastEpisodeToAir = LastEpisodeToAir(
    id: 1,
    name: "name",
    overview: "overview",
    voteAverage: 1,
    voteCount: 1,
    airDate: "airdate",
    episodeNumber: 1,
    productionCode: "productioncode",
    seasonNumber: 1,
    showId: 1,
    stillPath: "stillpath");

final testLastEpisodeToAirModel = LastEpisodeToAirModel(
    id: 1,
    name: "name",
    overview: "overview",
    voteAverage: 1,
    voteCount: 1,
    airDate: "airdate",
    episodeNumber: 1,
    productionCode: "productioncode",
    seasonNumber: 1,
    showId: 1,
    stillPath: "stillpath");

final testTvshowDetailData = TvshowDetail(
  adult: false,
  backdropPath: "/5S0SI4NjyMji05OPL0GOZ4BsiMh.jpg",
  createdBy: [
    CreatedBy(
        id: 1,
        creditId: "creditid",
        name: "name",
        gender: 1,
        profilePath: "profilepath")
  ],
  episodeRunTime: [1, 2, 3],
  firstAirDate: "2020-01-20",
  genres: [Genre(id: 1, name: 'Action')],
  homepage: "homepage",
  id: 1,
  inProduction: false,
  languages: ["en"],
  lastAirDate: "2020-01-20",
  lastEpisodeToAir: testLastEpisodeToAir,
  name: "name",
  nextEpisodeToAir: testLastEpisodeToAir,
  networks: [
    Networks(
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
    ProductionCompanies(
        id: 1,
        logoPath: "/path.jpg",
        name: "name",
        originCountry: "originCountry")
  ],
  productionCountries: [ProductionCountries(iso31661: "iso", name: "name")],
  seasons: [
    Seasons(
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
    SpokenLanguages(englishName: "englishName", iso6391: "iso", name: "name")
  ],
  status: "status",
  tagline: "tagline",
  type: "type",
  voteAverage: 6.3,
  voteCount: 6,
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
  type: "movie",
);

final testWatchlistTvshow = Tvshow.watchlist(
  id: 1,
  originalName: 'Lang Leve de Liefde',
  posterPath: '/5S0SI4NjyMji05OPL0GOZ4BsiMh.jpg',
  overview: 'overview',
  type: "tvshow",
);

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
  type: "movie",
);

final testMovieTableTvshow = MovieTable(
  id: 1,
  title: 'Lang Leve de Liefde',
  posterPath: '/5S0SI4NjyMji05OPL0GOZ4BsiMh.jpg',
  overview: 'overview',
  type: "tvshow",
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
  'type': "movie",
};

final testTvshowMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'originalName': 'title',
};
