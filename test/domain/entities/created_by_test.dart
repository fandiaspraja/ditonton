import 'package:ditonton/data/models/created_by_model.dart';
import 'package:ditonton/domain/entities/created_by.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tCreatedBy = CreatedBy(
    id: 1,
    creditId: 'creditId',
    name: 'name',
    originalName: 'originalName',
    gender: 1,
    profilePath: 'profilePath',
  );

  final tCreatedByModel = CreatedByModel(
    id: 1,
    creditId: 'creditId',
    name: 'name',
    originalName: 'originalName',
    gender: 1,
    profilePath: 'profilePath',
  );
  group('CreatedBy', () {
    test('supports value comparisons', () {
      expect(tCreatedBy, tCreatedByModel.toEntity());
    });
  });
}
