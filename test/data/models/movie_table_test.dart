import 'package:ditonton/data/models/movie_table.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  test('should be a subclass of Movie Table entity', () async {
    final result = testMovieTable.toEntity();
    expect(result, testWatchlistMovie);
  });

  test('should be a subclass of Tv Show Table entity', () async {
    final result = testMovieTableTvshow.toEntityTvshow();
    expect(result, testWatchlistTvshow);
  });

  group('fromEntity', () {
    test('should return a valid model from MovieDetail', () async {
      // act
      final result = MovieTable.fromEntity(testMovieDetail);
      // assert
      expect(result, testMovieTable);
    });

    test('should return a valid model from TvshowDetail', () async {
      // act
      final result = MovieTable.fromEntityTvshow(testTvshowDetail);
      // assert
      expect(result, testMovieTableTvshow);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // act
      final result = testMovieTable.toJson();
      // assert
      final expectedJsonMap = {
        'id': 1,
        'title': 'title',
        'posterPath': 'posterPath',
        'overview': 'overview',
        'type': 'movie'
      };
      expect(result, equals(expectedJsonMap));
    });
  });
}
