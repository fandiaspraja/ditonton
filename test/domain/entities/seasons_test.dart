import 'package:ditonton/data/models/seasons_model.dart';
import 'package:ditonton/domain/entities/seasons.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tSeasons = Seasons(
    airDate: 'airDate',
    episodeCount: 1,
    id: 1,
    name: 'name',
    overview: 'overview',
    posterPath: 'posterPath',
    seasonNumber: 1,
    voteAverage: 1,
  );

  final tSeasonsModel = SeasonsModel(
    airDate: 'airDate',
    episodeCount: 1,
    id: 1,
    name: 'name',
    overview: 'overview',
    posterPath: 'posterPath',
    seasonNumber: 1,
    voteAverage: 1,
  );
  group('Seasons', () {
    test('supports value comparisons', () {
      expect(
        tSeasons,
        tSeasonsModel.toEntity(),
      );
    });
  });
}
