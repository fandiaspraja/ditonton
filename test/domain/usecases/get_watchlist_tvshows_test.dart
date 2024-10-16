import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tvshows.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlistTvshows usecase;
  late MockTvshowRepository mockTvshowRepository;

  setUp(() {
    mockTvshowRepository = MockTvshowRepository();
    usecase = GetWatchlistTvshows(mockTvshowRepository);
  });

  test('should get list of tvshows from the repository', () async {
    // arrange
    when(mockTvshowRepository.getWatchlistTvshows())
        .thenAnswer((_) async => Right(testTvshowList));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(testTvshowList));
  });
}
