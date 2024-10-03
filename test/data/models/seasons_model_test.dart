import 'package:ditonton/data/models/seasons_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  final tSeasonsModel = SeasonsModel(
    airDate: "airDate",
    episodeCount: 1,
    id: 1,
    name: "name",
    overview: "overview",
    posterPath: "posterPath",
    seasonNumber: 1,
    voteAverage: 1,
  );

  final tSeasons = testSeasons;

  test('should be a subclass of Seasons entity', () async {
    final result = tSeasonsModel.toEntity();
    expect(result, tSeasons);
  });

  group('fromJSON', () {
    test('should parse JSON correctly', () async {
      // GIVEN
      final Map<String, dynamic> jsonMap = {
        "air_date": "airDate",
        "episode_count": 1,
        "id": 1,
        "name": "name",
        "overview": "overview",
        "poster_path": "posterPath",
        "season_number": 1,
        "vote_average": 1,
      };
      // WHEN
      final result = SeasonsModel.fromJson(jsonMap);
      // THEN
      expect(result.airDate, tSeasonsModel.airDate);
      expect(result.episodeCount, tSeasonsModel.episodeCount);
      expect(result.id, tSeasonsModel.id);
      expect(result.name, tSeasonsModel.name);
      expect(result.overview, tSeasonsModel.overview);
      expect(result.posterPath, tSeasonsModel.posterPath);
      expect(result.seasonNumber, tSeasonsModel.seasonNumber);
      expect(result.voteAverage, tSeasonsModel.voteAverage);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // ACT
      final result = tSeasonsModel.toJson();
      // ASSERT
      final expectedMap = {
        "air_date": "airDate",
        "episode_count": 1,
        "id": 1,
        "name": "name",
        "overview": "overview",
        "poster_path": "posterPath",
        "season_number": 1,
        "vote_average": 1,
      };
      expect(result, expectedMap);
    });
  });
}
