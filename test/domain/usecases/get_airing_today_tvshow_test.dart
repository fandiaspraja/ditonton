import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tvshow.dart';
import 'package:ditonton/domain/usecases/get_airing_today_tvshows.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetAiringTodayTvshows usecase;
  late MockTvshowRepository mockTvshowRepository;

  setUp(() {
    mockTvshowRepository = MockTvshowRepository();
    usecase = GetAiringTodayTvshows(mockTvshowRepository);
  });

  final tTvhsows = <Tvshow>[];

  test('should get list of tvshow from the repository', () async {
    // arrange
    when(mockTvshowRepository.getTvshowAiringTodays())
        .thenAnswer((_) async => Right(tTvhsows));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tTvhsows));
  });
}
