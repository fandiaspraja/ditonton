import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tvshow.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveWatchlistTvshow usecase;
  late MockTvshowRepository mockTvshowRepository;

  setUp(() {
    mockTvshowRepository = MockTvshowRepository();
    usecase = RemoveWatchlistTvshow(mockTvshowRepository);
  });

  test('should remove watchlist tvshow from repository', () async {
    // arrange
    when(mockTvshowRepository.removeWatchlist(testTvshowDetail))
        .thenAnswer((_) async => Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testTvshowDetail);
    // assert
    verify(mockTvshowRepository.removeWatchlist(testTvshowDetail));
    expect(result, Right('Removed from watchlist'));
  });
}
