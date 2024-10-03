import 'package:ditonton/data/models/production_companies_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  final tProductionCompaniesModel = ProductionCompaniesModel(
    id: 1,
    logoPath: "/path.jpg",
    name: "name",
    originCountry: "originCountry",
  );

  final tProductionCompanies = testProductionCompanies;

  test('should be a subclass of ProductionCompanies entity', () async {
    final result = tProductionCompaniesModel.toEntity();
    expect(result, tProductionCompanies);
  });

  group('fromJSON', () {
    test('should parse JSON correctly', () async {
      // GIVEN
      final Map<String, dynamic> jsonMap = {
        "id": 1,
        "logo_path": "/path.jpg",
        "name": "name",
        "origin_country": "originCountry",
      };
      // WHEN
      final result = ProductionCompaniesModel.fromJson(jsonMap);
      // THEN
      expect(result.id, tProductionCompaniesModel.id);
      expect(result.logoPath, tProductionCompaniesModel.logoPath);
      expect(result.name, tProductionCompaniesModel.name);
      expect(result.originCountry, tProductionCompaniesModel.originCountry);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // ACT
      final result = tProductionCompaniesModel.toJson();
      // ASSERT
      final expectedMap = {
        "id": 1,
        "logo_path": "/path.jpg",
        "name": "name",
        "origin_country": "originCountry",
      };
      expect(result, expectedMap);
    });
  });
}
