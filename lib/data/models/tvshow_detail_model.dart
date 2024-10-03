import 'package:ditonton/data/models/created_by_model.dart';
import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/last_episode_to_air_model.dart';
import 'package:ditonton/data/models/networks_model.dart';
import 'package:ditonton/data/models/production_companies_model.dart';
import 'package:ditonton/data/models/production_countries_model.dart';
import 'package:ditonton/data/models/seasons_model.dart';
import 'package:ditonton/data/models/spoken_languages_model.dart';
import 'package:ditonton/domain/entities/tvshow_detail.dart';
import 'package:equatable/equatable.dart';

class TvshowDetailResponse extends Equatable {
  TvshowDetailResponse(
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
  List<CreatedByModel>? createdBy;
  List<int>? episodeRunTime;
  String? firstAirDate;

  final List<GenreModel>? genres;
  final String? homepage;
  final int? id;
  bool? inProduction;
  List<String>? languages;
  String? lastAirDate;
  LastEpisodeToAirModel? lastEpisodeToAir;
  String? name;
  LastEpisodeToAirModel? nextEpisodeToAir;
  List<NetworksModel>? networks;
  int? numberOfEpisodes;
  int? numberOfSeasons;
  List<String>? originCountry;
  String? originalLanguage;
  String? originalName;
  String? overview;
  double? popularity;
  String? posterPath;
  List<ProductionCompaniesModel>? productionCompanies;
  List<ProductionCountriesModel>? productionCountries;
  List<SeasonsModel>? seasons;
  List<SpokenLanguagesModel>? spokenLanguages;
  String? status;
  String? tagline;
  String? type;
  double? voteAverage;
  int? voteCount;

  factory TvshowDetailResponse.fromJson(Map<String, dynamic> json) =>
      TvshowDetailResponse(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        createdBy: json["created_by"] != null
            ? List<CreatedByModel>.from(
                json["created_by"].map((x) => CreatedByModel.fromJson(x)))
            : [],
        episodeRunTime: json["episode_run_time"] != null
            ? List<int>.from(json["episode_run_time"].map((x) => x))
            : [],
        firstAirDate: json["first_air_date"],
        genres: List<GenreModel>.from(
            json["genres"].map((x) => GenreModel.fromJson(x))),
        homepage: json["homepage"],
        id: json["id"],
        inProduction: json["in_production"],
        languages: List<String>.from(json["languages"].map((x) => x)),
        lastAirDate: json["last_air_date"],
        lastEpisodeToAir: json["last_episode_to_air"] != null
            ? LastEpisodeToAirModel.fromJson(json["last_episode_to_air"])
            : null,
        name: json["name"],
        nextEpisodeToAir: json["next_episode_to_air"] != null
            ? LastEpisodeToAirModel.fromJson(json["next_episode_to_air"])
            : null,
        networks: List<NetworksModel>.from(
            json["networks"].map((x) => NetworksModel.fromJson(x))),
        numberOfEpisodes: json["number_of_episodes"],
        numberOfSeasons: json["number_of_seasons"],
        originCountry: List<String>.from(json["origin_country"].map((x) => x)),
        originalLanguage: json["original_language"],
        originalName: json["original_name"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        productionCompanies: List<ProductionCompaniesModel>.from(
            json["production_companies"]
                .map((x) => ProductionCompaniesModel.fromJson(x))),
        productionCountries: List<ProductionCountriesModel>.from(
            json["production_countries"]
                .map((x) => ProductionCountriesModel.fromJson(x))),
        seasons: List<SeasonsModel>.from(
            json["seasons"].map((x) => SeasonsModel.fromJson(x))),
        spokenLanguages: List<SpokenLanguagesModel>.from(
            json["spoken_languages"]
                .map((x) => SpokenLanguagesModel.fromJson(x))),
        status: json["status"],
        tagline: json["tagline"],
        type: json["type"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );

  factory TvshowDetailResponse.fromJsonTest(Map<String, dynamic> json) =>
      TvshowDetailResponse(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        firstAirDate: json["first_air_date"],
        createdBy: [],
        episodeRunTime: [],
        genres: List<GenreModel>.from(
            json["genres"].map((x) => GenreModel.fromJson(x))),
        id: json["id"],
        originCountry: List<String>.from(json["origin_country"].map((x) => x)),
        originalLanguage: json["original_language"],
        originalName: json["original_name"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "created_by": List<dynamic>.from(createdBy!.map((x) => x.toJson())),
        "episode_run_time": List<dynamic>.from(episodeRunTime!.map((x) => x)),
        "first_air_date": firstAirDate,
        "genres": List<dynamic>.from(genres!.map((x) => x.toJson())),
        "homepage": homepage,
        "id": id,
        "in_production": inProduction,
        "languages": List<dynamic>.from(languages!.map((x) => x)),
        "last_air_date": lastAirDate,
        "last_episode_to_air": lastEpisodeToAir?.toJson(),
        "name": name,
        "next_episode_to_air": nextEpisodeToAir?.toJson(),
        "networks": List<dynamic>.from(networks!.map((x) => x.toJson())),
        "number_of_episodes": numberOfEpisodes,
        "number_of_seasons": numberOfSeasons,
        "origin_country": List<dynamic>.from(originCountry!.map((x) => x)),
        "original_language": originalLanguage,
        "original_name": originalName,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "production_companies":
            List<dynamic>.from(productionCompanies!.map((x) => x.toJson())),
        "production_countries":
            List<dynamic>.from(productionCountries!.map((x) => x.toJson())),
        "seasons": List<dynamic>.from(seasons!.map((x) => x.toJson())),
        "spoken_languages":
            List<dynamic>.from(spokenLanguages!.map((x) => x.toJson())),
        "status": status,
        "tagline": tagline,
        "type": type,
        "vote_average": voteAverage,
        "vote_count": voteCount
      };

  TvshowDetail toEntity() {
    return TvshowDetail(
      adult: adult,
      backdropPath: backdropPath,
      createdBy:
          this.createdBy?.map((createdby) => createdby.toEntity()).toList(),
      episodeRunTime: episodeRunTime,
      firstAirDate: firstAirDate,
      genres: this.genres?.map((genre) => genre.toEntity()).toList(),
      homepage: homepage,
      id: id,
      inProduction: inProduction,
      languages: languages,
      lastAirDate: lastAirDate,
      lastEpisodeToAir: lastEpisodeToAir?.toEntity(),
      name: name,
      nextEpisodeToAir: lastEpisodeToAir?.toEntity(),
      networks: this.networks?.map((network) => network.toEntity()).toList(),
      numberOfEpisodes: numberOfEpisodes,
      numberOfSeasons: numberOfSeasons,
      originCountry: originCountry,
      originalLanguage: originalLanguage,
      originalName: originalName,
      overview: overview,
      popularity: popularity,
      posterPath: posterPath,
      productionCompanies: this
          .productionCompanies
          ?.map((prodcom) => prodcom.toEntity())
          .toList(),
      productionCountries: this
          .productionCountries
          ?.map((prodcount) => prodcount.toEntity())
          .toList(),
      seasons: this.seasons?.map((season) => season.toEntity()).toList(),
      spokenLanguages:
          this.spokenLanguages?.map((spoken) => spoken.toEntity()).toList(),
      status: status,
      tagline: tagline,
      type: type,
      voteAverage: voteAverage,
      voteCount: voteCount,
    );
  }

  @override
  // TODO: implement props
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
