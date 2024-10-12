import 'package:ditonton/data/models/tvshow_model.dart';
import 'package:ditonton/domain/entities/tvshow.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvshowModel = TvshowModel(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    firstAirDate: 'firstAirDate',
    name: 'name',
    voteAverage: 1,
    voteCount: 1,
  );

  final tTvshow = Tvshow(
      adult: false,
      backdropPath: 'backdropPath',
      genreIds: [1, 2, 3],
      id: 1,
      originalName: 'originalName',
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      firstAirDate: 'firstAirDate',
      name: 'name',
      voteAverage: 1,
      voteCount: 1,
      type: "tvshow");

  test('should be a subclass of Tvshow entity', () async {
    final result = tTvshowModel.toEntity();
    expect(result, tTvshow);
  });
}
