import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tvshow.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tvshows.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTopRatedTvshows usecase;
  late MockTvshowRepository mockTvshowRepository;

  setUp(() {
    mockTvshowRepository = MockTvshowRepository();
    usecase = GetTopRatedTvshows(mockTvshowRepository);
  });

  final tTvhsows = <Tvshow>[];

  test('should get list of tvshow from the repository', () async {
    // arrange
    when(mockTvshowRepository.getTvshowTopRated())
        .thenAnswer((_) async => Right(tTvhsows));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tTvhsows));
  });
}
