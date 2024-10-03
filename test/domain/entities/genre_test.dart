import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tGenre = Genre(
    id: 1,
    name: 'name',
  );

  final tGenreModel = GenreModel(
    id: 1,
    name: 'name',
  );

  group('Genre', () {
    test('supports value comparisons', () {
      expect(
        tGenre,
        tGenreModel.toEntity(),
      );
    });
  });
}
