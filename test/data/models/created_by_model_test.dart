import 'package:ditonton/data/models/created_by_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  final tCreatedBy = CreatedByModel(
      id: 1,
      creditId: "creditid",
      name: "name",
      gender: 1,
      profilePath: "profilepath");

  test('should be a subclass of Created by entity', () async {
    final result = tCreatedBy.toEntity();
    expect(result, testCreatedBy);
  });
}
