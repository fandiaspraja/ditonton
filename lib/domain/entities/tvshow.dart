import 'package:equatable/equatable.dart';

class Tvshow extends Equatable {
  Tvshow({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originCountry,
    this.originalLanguage,
    this.originalName,
    this.overview,
    this.popularity,
    this.posterPath,
    this.firstAirDate,
    this.name,
    this.voteAverage,
    this.voteCount,
    this.type,
  });

  Tvshow.watchlist({
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.originalName,
    required this.type,
  });

  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int? id;
  List<String>? originCountry;
  String? originalLanguage;
  String? originalName;
  String? overview;
  double? popularity;
  String? posterPath;
  String? firstAirDate;
  String? name;
  double? voteAverage;
  int? voteCount;
  String? type;

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        genreIds,
        id,
        originCountry,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        firstAirDate,
        name,
        voteAverage,
        voteCount,
        type,
      ];
}
