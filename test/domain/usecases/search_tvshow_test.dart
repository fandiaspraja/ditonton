import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tvshow.dart';
import 'package:ditonton/domain/usecases/search_tvshows.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late SearchTvshows usecase;
  late MockTvshowRepository mockTvshowRepository;

  setUp(() {
    mockTvshowRepository = MockTvshowRepository();
    usecase = SearchTvshows(mockTvshowRepository);
  });

  final tTvshows = <Tvshow>[];
  final tQuery = 'Lang Leve de Liefde';

  test('should get list of tvshow from the repository', () async {
    // arrange
    when(mockTvshowRepository.searchTvshows(tQuery))
        .thenAnswer((_) async => Right(tTvshows));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(tTvshows));
  });
}
