import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tvshow.dart';
import 'package:ditonton/domain/usecases/get_tvshow_recommendations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvshowRecommendations usecase;
  late MockTvshowRepository mockTvshowRepository;

  setUp(() {
    mockTvshowRepository = MockTvshowRepository();
    usecase = GetTvshowRecommendations(mockTvshowRepository);
  });

  final tTvhsows = <Tvshow>[];

  final tId = 1;

  test('should get list of tvshow from the repository', () async {
    // arrange
    when(mockTvshowRepository.getTvshowRecommendations(tId))
        .thenAnswer((_) async => Right(tTvhsows));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(tTvhsows));
  });
}
