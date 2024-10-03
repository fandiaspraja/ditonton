import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tvshow.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SaveWatchlistTvshow usecase;
  late MockTvshowRepository mockTvshowRepository;

  setUp(() {
    mockTvshowRepository = MockTvshowRepository();
    usecase = SaveWatchlistTvshow(mockTvshowRepository);
  });

  test('should save tvshow to the repository', () async {
    // arrange
    when(mockTvshowRepository.saveWatchlist(testTvshowDetail))
        .thenAnswer((_) async => Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testTvshowDetail);
    // assert
    verify(mockTvshowRepository.saveWatchlist(testTvshowDetail));
    expect(result, Right('Added to Watchlist'));
  });
}
