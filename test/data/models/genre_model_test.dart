import 'package:ditonton/data/models/genre_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  final tGenre = GenreModel(
    id: 1,
    name: "name",
  );

  test('should be a subclass of Genre entity', () async {
    final result = tGenre.toEntity();
    expect(result, testGenre);
  });
}
