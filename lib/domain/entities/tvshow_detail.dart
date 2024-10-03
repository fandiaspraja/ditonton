import 'package:ditonton/data/models/production_companies_model.dart';
import 'package:ditonton/data/models/production_countries_model.dart';
import 'package:ditonton/data/models/seasons_model.dart';
import 'package:ditonton/data/models/spoken_languages_model.dart';
import 'package:ditonton/domain/entities/created_by.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/last_episode_to_air.dart';
import 'package:ditonton/domain/entities/networks.dart';
import 'package:ditonton/domain/entities/production_companies.dart';
import 'package:ditonton/domain/entities/production_countries.dart';
import 'package:ditonton/domain/entities/seasons.dart';
import 'package:ditonton/domain/entities/spoken_languages.dart';
import 'package:equatable/equatable.dart';

class TvshowDetail extends Equatable {
  TvshowDetail(
      {this.adult,
      this.backdropPath,
      this.createdBy,
      this.episodeRunTime,
      this.firstAirDate,
      this.genres,
      this.homepage,
      this.id,
      this.inProduction,
      this.languages,
      this.lastAirDate,
      this.lastEpisodeToAir,
      this.name,
      this.nextEpisodeToAir,
      this.networks,
      this.numberOfEpisodes,
      this.numberOfSeasons,
      this.originCountry,
      this.originalLanguage,
      this.originalName,
      this.overview,
      this.popularity,
      this.posterPath,
      this.productionCompanies,
      this.productionCountries,
      this.seasons,
      this.spokenLanguages,
      this.status,
      this.tagline,
      this.type,
      this.voteAverage,
      this.voteCount});

  final bool? adult;
  final String? backdropPath;
  List<CreatedBy>? createdBy;
  List<int>? episodeRunTime;
  String? firstAirDate;
  final List<Genre>? genres;
  final String? homepage;
  final int? id;
  bool? inProduction;
  List<String>? languages;
  String? lastAirDate;
  LastEpisodeToAir? lastEpisodeToAir;
  String? name;
  LastEpisodeToAir? nextEpisodeToAir;
  List<Networks>? networks;
  int? numberOfEpisodes;
  int? numberOfSeasons;
  List<String>? originCountry;
  String? originalLanguage;
  String? originalName;
  String? overview;
  double? popularity;
  String? posterPath;
  List<ProductionCompanies>? productionCompanies;
  List<ProductionCountries>? productionCountries;
  List<Seasons>? seasons;
  List<SpokenLanguages>? spokenLanguages;
  String? status;
  String? tagline;
  String? type;
  double? voteAverage;
  int? voteCount;

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        createdBy,
        episodeRunTime,
        firstAirDate,
        genres,
        homepage,
        id,
        inProduction,
        languages,
        lastAirDate,
        lastEpisodeToAir,
        name,
        nextEpisodeToAir,
        networks,
        numberOfEpisodes,
        numberOfSeasons,
        originCountry,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        productionCompanies,
        productionCountries,
        seasons,
        spokenLanguages,
        status,
        tagline,
        type,
        voteAverage,
        voteCount
      ];
}
