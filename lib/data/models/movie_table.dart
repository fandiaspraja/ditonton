import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/tvshow.dart';
import 'package:ditonton/domain/entities/tvshow_detail.dart';
import 'package:equatable/equatable.dart';

class MovieTable extends Equatable {
  final int id;
  final String? title;
  final String? posterPath;
  final String? overview;
  final String? type;

  MovieTable({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
    required this.type,
  });

  factory MovieTable.fromEntity(MovieDetail movie) => MovieTable(
      id: movie.id,
      title: movie.title,
      posterPath: movie.posterPath,
      overview: movie.overview,
      type: "movie");

  factory MovieTable.fromEntityTvshow(TvshowDetail tvshow) => MovieTable(
      id: tvshow.id ?? 0,
      title: tvshow.name,
      posterPath: tvshow.posterPath,
      overview: tvshow.overview,
      type: "tvshow");

  factory MovieTable.fromMap(Map<String, dynamic> map) => MovieTable(
        id: map['id'],
        title: map['title'],
        posterPath: map['posterPath'],
        overview: map['overview'],
        type: map['type'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'posterPath': posterPath,
        'overview': overview,
        'type': type
      };

  Movie toEntity() => Movie.watchlist(
      id: id,
      overview: overview,
      posterPath: posterPath,
      title: title,
      type: type);

  Tvshow toEntityTvshow() => Tvshow.watchlist(
        id: id,
        overview: overview,
        posterPath: posterPath,
        originalName: title,
        type: type,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [id, title, posterPath, overview, type];
}
