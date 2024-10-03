import 'package:ditonton/data/models/spoken_languages_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  final tSpokenLanguagesModel = SpokenLanguagesModel(
    englishName: "englishName",
    iso6391: "iso",
    name: "name",
  );

  final tSpokenLanguages = testSpokenLanguages;

  test('should be a subclass of SpokenLanguages entity', () async {
    final result = tSpokenLanguagesModel.toEntity();
    expect(result, tSpokenLanguages);
  });

  group('fromJSON', () {
    test('should parse JSON correctly', () async {
      // GIVEN
      final Map<String, dynamic> jsonMap = {
        "english_name": "englishName",
        "iso_639_1": "iso",
        "name": "name",
      };
      // WHEN
      final result = SpokenLanguagesModel.fromJson(jsonMap);
      // THEN
      expect(result.englishName, tSpokenLanguagesModel.englishName);
      expect(result.iso6391, tSpokenLanguagesModel.iso6391);
      expect(result.name, tSpokenLanguagesModel.name);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // ACT
      final result = tSpokenLanguagesModel.toJson();
      // ASSERT
      final expectedMap = {
        "english_name": "englishName",
        "iso_639_1": "iso",
        "name": "name",
      };
      expect(result, expectedMap);
    });
  });
}
