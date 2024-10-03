import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tvshow.dart';
import 'package:ditonton/domain/usecases/get_popular_tvshows.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetPopularTvshows usecase;
  late MockTvshowRepository mockTvshowRepository;

  setUp(() {
    mockTvshowRepository = MockTvshowRepository();
    usecase = GetPopularTvshows(mockTvshowRepository);
  });

  final tTvhsows = <Tvshow>[];

  test('should get list of tvshow from the repository', () async {
    // arrange
    when(mockTvshowRepository.getTvshowPopular())
        .thenAnswer((_) async => Right(tTvhsows));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tTvhsows));
  });
}
