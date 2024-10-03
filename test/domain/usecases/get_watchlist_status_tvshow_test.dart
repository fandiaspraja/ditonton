import 'package:ditonton/domain/usecases/get_watchlist_status_tvshow.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchListStatusTvshow usecase;
  late MockTvshowRepository mockTvshowRepository;

  setUp(() {
    mockTvshowRepository = MockTvshowRepository();
    usecase = GetWatchListStatusTvshow(mockTvshowRepository);
  });

  test('should get watchlist tvshow status from repository', () async {
    // arrange
    when(mockTvshowRepository.isAddedToWatchlist(1))
        .thenAnswer((_) async => true);
    // act
    final result = await usecase.execute(1);
    // assert
    expect(result, true);
  });
}
