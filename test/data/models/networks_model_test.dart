import 'package:ditonton/data/models/networks_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  final tNetworksModel = NetworksModel(
    id: 1,
    logoPath: "/path.jpg",
    name: "name",
    originCountry: "originCountry",
  );

  final tNetworks = testNetworks;

  test('should be a subclass of Networks entity', () async {
    final result = tNetworksModel.toEntity();
    expect(result, tNetworks);
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
      final result = NetworksModel.fromJson(jsonMap);
      // THEN
      expect(result.id, tNetworksModel.id);
      expect(result.logoPath, tNetworksModel.logoPath);
      expect(result.name, tNetworksModel.name);
      expect(result.originCountry, tNetworksModel.originCountry);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // ACT
      final result = tNetworksModel.toJson();
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
