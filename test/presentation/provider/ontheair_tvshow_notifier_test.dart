import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tvshow.dart';
import 'package:ditonton/domain/usecases/get_airing_today_tvshows.dart';
import 'package:ditonton/domain/usecases/get_ontheair_tvshows.dart';
import 'package:ditonton/presentation/provider/ontheair_tvshow_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'ontheair_tvshow_notifier_test.mocks.dart';

@GenerateMocks([GetOntheairTvshows])
void main() {
  late MockGetOntheairTvshows mockGetOntheairTvshows;
  late OntheairTvshowNotifier provider;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetOntheairTvshows = MockGetOntheairTvshows();
    provider =
        OntheairTvshowNotifier(getOntheairTvshows: mockGetOntheairTvshows)
          ..addListener(() {
            listenerCallCount++;
          });
  });

  final tTvshow = Tvshow(
      adult: false,
      backdropPath: "/5S0SI4NjyMji05OPL0GOZ4BsiMh.jpg",
      genreIds: [1, 2, 3],
      id: 136166,
      originCountry: ["NL"],
      originalLanguage: "nl",
      originalName: 'Lang Leve de Liefde',
      overview: 'overview',
      popularity: 3416.968,
      posterPath: "/9lpvvzEl5kViIc2vUJG4QKzj2ds.jpg",
      firstAirDate: "2020-01-20",
      name: "Lang Leve de Liefde",
      voteAverage: 6.3,
      voteCount: 6);

  final tTvshowList = <Tvshow>[tTvshow];

  group('on the air tvshows', () {
    test('initialState should be Empty', () {
      expect(provider.onTheAirTvshowsState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetOntheairTvshows.execute())
          .thenAnswer((_) async => Right(tTvshowList));
      // act
      provider.fetchOntheairTvshows();
      // assert
      verify(mockGetOntheairTvshows.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetOntheairTvshows.execute())
          .thenAnswer((_) async => Right(tTvshowList));
      // act
      provider.fetchOntheairTvshows();
      // assert
      expect(provider.onTheAirTvshowsState, RequestState.Loading);
    });

    test('should change tvshows when data is gotten successfully', () async {
      // arrange
      when(mockGetOntheairTvshows.execute())
          .thenAnswer((_) async => Right(tTvshowList));
      // act
      await provider.fetchOntheairTvshows();
      // assert
      expect(provider.onTheAirTvshowsState, RequestState.Loaded);
      expect(provider.onTheAirTvshows, tTvshowList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetOntheairTvshows.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchOntheairTvshows();
      // assert
      expect(provider.onTheAirTvshowsState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
