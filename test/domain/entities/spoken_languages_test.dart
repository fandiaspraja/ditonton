import 'package:ditonton/data/models/spoken_languages_model.dart';
import 'package:ditonton/domain/entities/spoken_languages.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tSpokenLanguages = SpokenLanguages(
    englishName: 'englishName',
    iso6391: 'iso6391',
    name: 'name',
  );

  final tSpokenLanguagesModel = SpokenLanguagesModel(
    englishName: 'englishName',
    iso6391: 'iso6391',
    name: 'name',
  );
  group('SpokenLanguages', () {
    test('supports value comparisons', () {
      expect(
        tSpokenLanguages,
        tSpokenLanguagesModel.toEntity(),
      );
    });
  });
}
