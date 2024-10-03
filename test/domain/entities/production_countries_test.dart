import 'package:ditonton/data/models/production_countries_model.dart';
import 'package:ditonton/domain/entities/production_countries.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tProductionCountries = ProductionCountries(
    iso31661: 'iso31661',
    name: 'name',
  );

  final tProductionCountriesModel = ProductionCountriesModel(
    iso31661: 'iso31661',
    name: 'name',
  );
  group('ProductionCountries', () {
    test('supports value comparisons', () {
      expect(
        tProductionCountries,
        tProductionCountriesModel.toEntity(),
      );
    });
  });
}
