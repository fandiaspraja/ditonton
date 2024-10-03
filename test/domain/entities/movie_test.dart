import 'package:ditonton/data/models/movie_model.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tMovie = Movie(
    adult: false,
    backdropPath: '/path.jpg',
    genreIds: [1, 2, 3, 4],
    id: 1,
    originalTitle: 'Original Title',
    overview: 'Overview',
    popularity: 1.0,
    posterPath: '/path.jpg',
    releaseDate: '2022-01-01',
    title: 'Title',
    video: false,
    voteAverage: 1.0,
    voteCount: 1,
    type: 'Movie',
  );

  final tMovieModel = MovieModel(
    adult: false,
    backdropPath: '/path.jpg',
    genreIds: [1, 2, 3, 4],
    id: 1,
    originalTitle: 'Original Title',
    overview: 'Overview',
    popularity: 1.0,
    posterPath: '/path.jpg',
    releaseDate: '2022-01-01',
    title: 'Title',
    video: false,
    voteAverage: 1.0,
    voteCount: 1,
  );

  group('Movie', () {
    test('supports value comparisons', () {
      expect(tMovie.id, tMovieModel.toEntity().id);
    });
  });
}
