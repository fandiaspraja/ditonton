import 'package:ditonton/data/models/last_episode_to_air_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  final tLastEpisodeToAir = LastEpisodeToAirModel(
      id: 1,
      name: "name",
      overview: "overview",
      voteAverage: 1,
      voteCount: 1,
      airDate: "airdate",
      episodeNumber: 1,
      productionCode: "productioncode",
      seasonNumber: 1,
      showId: 1,
      stillPath: "stillpath");

  test('should be a subclass of Last Episode To Air entity', () async {
    final result = tLastEpisodeToAir.toEntity();
    expect(result, testLastEpisodeToAir);
  });
}
