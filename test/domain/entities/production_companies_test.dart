import 'package:ditonton/data/models/production_companies_model.dart';
import 'package:ditonton/domain/entities/production_companies.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tProductionCompanies = ProductionCompanies(
    id: 1,
    logoPath: 'logoPath',
    name: 'name',
    originCountry: 'originCountry',
  );

  final tProductionCompaniesModel = ProductionCompaniesModel(
    id: 1,
    logoPath: 'logoPath',
    name: 'name',
    originCountry: 'originCountry',
  );
  group('ProductionCompanies', () {
    test('supports value comparisons', () {
      expect(
        tProductionCompanies,
        tProductionCompaniesModel.toEntity(),
      );
    });
  });
}
