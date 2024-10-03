import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tvshow.dart';
import 'package:ditonton/domain/usecases/get_ontheair_tvshows.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetOntheairTvshows usecase;
  late MockTvshowRepository mockTvshowRepository;

  setUp(() {
    mockTvshowRepository = MockTvshowRepository();
    usecase = GetOntheairTvshows(mockTvshowRepository);
  });

  final tTvhsows = <Tvshow>[];

  test('should get list of tvshow from the repository', () async {
    // arrange
    when(mockTvshowRepository.getTvshowOntheAir())
        .thenAnswer((_) async => Right(tTvhsows));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tTvhsows));
  });
}
