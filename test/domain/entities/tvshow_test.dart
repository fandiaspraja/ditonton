import 'package:ditonton/data/models/tvshow_model.dart';
import 'package:ditonton/domain/entities/tvshow.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvshow = Tvshow(
    adult: false,
    backdropPath: '/path.jpg',
    genreIds: const [1, 2, 3, 4],
    id: 1,
    originCountry: const ['US'],
    originalLanguage: 'en',
    originalName: 'Original Name',
    overview: 'Overview',
    popularity: 1.0,
    posterPath: '/path.jpg',
    firstAirDate: '2022-01-01',
    name: 'Name',
    voteAverage: 1.0,
    voteCount: 1,
    type: 'tvshow',
  );

  final tTvshowModel = TvshowModel(
    adult: false,
    backdropPath: '/path.jpg',
    genreIds: const [1, 2, 3, 4],
    id: 1,
    originCountry: const ['US'],
    originalLanguage: 'en',
    originalName: 'Original Name',
    overview: 'Overview',
    popularity: 1.0,
    posterPath: '/path.jpg',
    firstAirDate: '2022-01-01',
    name: 'Name',
    voteAverage: 1.0,
    voteCount: 1,
  );

  group('Tv Show', () {
    test('supports value comparisons', () {
      expect(tTvshow, tTvshowModel.toEntity());
    });
  });
}
