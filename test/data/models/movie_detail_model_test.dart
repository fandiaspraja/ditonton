import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/movie_detail_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  final tMovieDetailModel = MovieDetailResponse(
    adult: true,
    backdropPath: "backdropPath",
    budget: 100,
    genres: [GenreModel(id: 1, name: 'Action')],
    homepage: "homepage",
    id: 1,
    imdbId: "imdbId",
    originalLanguage: "originalLanguage",
    originalTitle: "originalTitle",
    overview: "overview",
    popularity: 0.0,
    posterPath: "posterPath",
    releaseDate: "releaseDate",
    revenue: 100,
    runtime: 1,
    status: "status",
    tagline: "tagline",
    title: "title",
    video: false,
    voteAverage: 5.0,
    voteCount: 5,
  );

  test('should be a subclass of Movie Detail entity', () async {
    final result = tMovieDetailModel.toEntity();
    expect(result, testMovieDetailModel);
  });
}
