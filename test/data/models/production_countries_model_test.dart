import 'package:ditonton/data/models/production_countries_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  final tProductionCountriesModel = ProductionCountriesModel(
    iso31661: "iso",
    name: "name",
  );

  final tProductionCountries = testProductionCountries;

  test('should be a subclass of ProductionCountries entity', () async {
    final result = tProductionCountriesModel.toEntity();
    expect(result, tProductionCountries);
  });

  group('fromJSON', () {
    test('should parse JSON correctly', () async {
      // GIVEN
      final Map<String, dynamic> jsonMap = {
        "iso_3166_1": "iso",
        "name": "name",
      };
      // WHEN
      final result = ProductionCountriesModel.fromJson(jsonMap);
      // THEN
      expect(result.iso31661, tProductionCountriesModel.iso31661);
      expect(result.name, tProductionCountriesModel.name);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // ACT
      final result = tProductionCountriesModel.toJson();
      // ASSERT
      final expectedMap = {
        "iso_3166_1": "iso",
        "name": "name",
      };
      expect(result, expectedMap);
    });
  });
}
