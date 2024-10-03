import 'package:ditonton/data/models/networks_model.dart';
import 'package:ditonton/domain/entities/networks.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tNetworks = Networks(
    id: 1,
    logoPath: 'logoPath',
    name: 'name',
    originCountry: 'originCountry',
  );

  final tNetworksModel = NetworksModel(
    id: 1,
    logoPath: 'logoPath',
    name: 'name',
    originCountry: 'originCountry',
  );
  group('Networks', () {
    test('supports value comparisons', () {
      expect(
        tNetworks,
        tNetworksModel.toEntity(),
      );
    });
  });
}
