import 'package:ditonton/domain/entities/last_episode_to_air.dart';

class LastEpisodeToAirModel {
  int? id;
  String? name;
  String? overview;
  double? voteAverage;
  int? voteCount;
  String? airDate;
  int? episodeNumber;
  String? episodeType;
  String? productionCode;
  int? runtime;
  int? seasonNumber;
  int? showId;
  String? stillPath;

  LastEpisodeToAirModel(
      {this.id,
      this.name,
      this.overview,
      this.voteAverage,
      this.voteCount,
      this.airDate,
      this.episodeNumber,
      this.episodeType,
      this.productionCode,
      this.runtime,
      this.seasonNumber,
      this.showId,
      this.stillPath});

  factory LastEpisodeToAirModel.fromJson(Map<String, dynamic> json) =>
      LastEpisodeToAirModel(
        id: json['id'],
        name: json['name'],
        overview: json['overview'],
        voteAverage: double.parse(json['vote_average'].toString()),
        voteCount: json['vote_count'],
        airDate: json['air_date'],
        episodeNumber: json['episode_number'],
        episodeType: json['episode_type'],
        productionCode: json['production_code'],
        runtime: json['runtime'],
        seasonNumber: json['season_number'],
        showId: json['show_id'],
        stillPath: json['still_path'],
      );

  LastEpisodeToAir toEntity() {
    return LastEpisodeToAir(
      id: this.id,
      name: this.name,
      overview: this.overview,
      voteAverage: this.voteAverage,
      voteCount: this.voteCount,
      airDate: this.airDate,
      episodeNumber: this.episodeNumber,
      episodeType: this.episodeType,
      productionCode: this.productionCode,
      runtime: this.runtime,
      seasonNumber: this.seasonNumber,
      showId: this.showId,
      stillPath: this.stillPath,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "overview": overview,
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "air_date": airDate,
        "episode_number": episodeNumber,
        "episode_type": episodeType,
        "production_code": productionCode,
        "runtime": runtime,
        "season_number": seasonNumber,
        "show_id": showId,
        "still_path": stillPath,
      };
}
