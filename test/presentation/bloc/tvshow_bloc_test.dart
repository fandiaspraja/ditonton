import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tvshow.dart';
import 'package:ditonton/domain/entities/tvshow_detail.dart';
import 'package:ditonton/domain/usecases/get_airing_today_tvshows.dart';
import 'package:ditonton/domain/usecases/get_ontheair_tvshows.dart';
import 'package:ditonton/domain/usecases/get_popular_tvshows.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tvshows.dart';
import 'package:ditonton/domain/usecases/get_tvshow_detail.dart';
import 'package:ditonton/domain/usecases/get_tvshow_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status_tvshow.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tvshows.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tvshow.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tvshow.dart';
import 'package:ditonton/domain/usecases/search_tvshows.dart';
import 'package:ditonton/presentation/bloc/tvshow/tvshow_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:mockito/mockito.dart';

import 'tvshow_bloc_test.mocks.dart';

@GenerateMocks([
  GetTvshowDetail,
  GetTvshowRecommendations,
  GetAiringTodayTvshows,
  GetOntheairTvshows,
  GetPopularTvshows,
  GetTopRatedTvshows,
  GetWatchlistTvshows,
  GetWatchListStatusTvshow,
  RemoveWatchlistTvshow,
  SaveWatchlistTvshow,
  SearchTvshows,
])
void main() {
  late AiringTodayTvshowBloc airingTodayTvshowBloc;
  late OnTheAirTvshowBloc onTheAirTvshowBloc;
  late PopularTvshowBloc popularTvshowBloc;
  late TopRatedTvshowBloc topRatedTvshowBloc;
  late TvshowDetailBloc tvshowDetailBloc;
  late TvshowRecommendationBloc tvshowRecommendationBloc;
  late WatchlistTvshowBloc watchlistTvshowBloc;
  late SearchTvshowBloc searchTvshowBloc;

  late MockGetTvshowDetail mockGetTvshowDetail;
  late MockGetTvshowRecommendations mockGetTvshowRecommendations;
  late MockGetAiringTodayTvshows mockGetAiringTodayTvshows;
  late MockGetOntheairTvshows mockGetOntheairTvshows;
  late MockGetPopularTvshows mockGetPopularTvshows;
  late MockGetTopRatedTvshows mockGetTopRatedTvshows;
  late MockGetWatchlistTvshows mockGetWatchlistTvshows;
  late MockGetWatchListStatusTvshow mockGetWatchListStatusTvshow;
  late MockRemoveWatchlistTvshow mockRemoveWatchlistTvshow;
  late MockSaveWatchlistTvshow mockSaveWatchlistTvshow;
  late MockSearchTvshows mockSearchTvshows;

  setUp(() {
    mockGetTvshowDetail = MockGetTvshowDetail();
    mockGetTvshowRecommendations = MockGetTvshowRecommendations();
    mockGetAiringTodayTvshows = MockGetAiringTodayTvshows();
    mockGetOntheairTvshows = MockGetOntheairTvshows();
    mockGetPopularTvshows = MockGetPopularTvshows();
    mockGetTopRatedTvshows = MockGetTopRatedTvshows();
    mockGetWatchlistTvshows = MockGetWatchlistTvshows();
    mockSaveWatchlistTvshow = MockSaveWatchlistTvshow();
    mockRemoveWatchlistTvshow = MockRemoveWatchlistTvshow();
    mockGetWatchListStatusTvshow = MockGetWatchListStatusTvshow();
    mockSearchTvshows = MockSearchTvshows();

    airingTodayTvshowBloc = AiringTodayTvshowBloc(mockGetAiringTodayTvshows);
    onTheAirTvshowBloc = OnTheAirTvshowBloc(mockGetOntheairTvshows);
    popularTvshowBloc = PopularTvshowBloc(mockGetPopularTvshows);
    topRatedTvshowBloc = TopRatedTvshowBloc(mockGetTopRatedTvshows);
    tvshowDetailBloc = TvshowDetailBloc(mockGetTvshowDetail);
    tvshowRecommendationBloc =
        TvshowRecommendationBloc(mockGetTvshowRecommendations);
    watchlistTvshowBloc = WatchlistTvshowBloc(
        mockGetWatchlistTvshows,
        mockGetWatchListStatusTvshow,
        mockSaveWatchlistTvshow,
        mockRemoveWatchlistTvshow);
    searchTvshowBloc = SearchTvshowBloc(mockSearchTvshows);
  });

  final testTvshow = Tvshow(
      adult: false,
      backdropPath: "/5S0SI4NjyMji05OPL0GOZ4BsiMh.jpg",
      genreIds: [1, 2, 3],
      id: 1,
      originCountry: ["NL"],
      originalLanguage: "nl",
      originalName: 'Lang Leve de Liefde',
      overview: 'overview',
      popularity: 3416.968,
      posterPath: "/5S0SI4NjyMji05OPL0GOZ4BsiMh.jpg",
      firstAirDate: "2020-01-20",
      name: "Lang Leve de Liefde",
      voteAverage: 6.3,
      voteCount: 6);

  final tQuery = "Lang Leve";

  final testTvshowList = [testTvshow];

  final testTvshowDetail = TvshowDetail(
    adult: false,
    backdropPath: "/5S0SI4NjyMji05OPL0GOZ4BsiMh.jpg",
    genres: [Genre(id: 1, name: 'Action')],
    id: 1,
    originCountry: ["NL"],
    originalLanguage: "nl",
    originalName: 'Lang Leve de Liefde',
    overview: 'overview',
    popularity: 3416.968,
    posterPath: "/5S0SI4NjyMji05OPL0GOZ4BsiMh.jpg",
    firstAirDate: "2020-01-20",
    name: "Lang Leve de Liefde",
    voteAverage: 6.3,
    voteCount: 6,
  );

  final tId = 1;

  group('Get airing today tvshows', () {
    test('initial state must be empty', () {
      expect(airingTodayTvshowBloc.state, TvshowLoading());
    });

    blocTest(
      'should emit[loading, tvshowsHasData] when data is gotten succesfully',
      build: () {
        when(mockGetAiringTodayTvshows.execute())
            .thenAnswer((_) async => Right(testTvshowList));
        return airingTodayTvshowBloc;
      },
      act: (AiringTodayTvshowBloc bloc) => bloc.add(FetchAiringTodayTvshows()),
      wait: Duration(milliseconds: 500),
      expect: () => [TvshowLoading(), TvshowsHasData(testTvshowList)],
    );

    blocTest(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetAiringTodayTvshows.execute()).thenAnswer(
            (realInvocation) async => Left(ServerFailure('Server Failure')));
        return airingTodayTvshowBloc;
      },
      act: (AiringTodayTvshowBloc bloc) => bloc.add(FetchAiringTodayTvshows()),
      wait: Duration(milliseconds: 500),
      expect: () => [
        TvshowLoading(),
        TvshowsError('Server Failure'),
      ],
      verify: (AiringTodayTvshowBloc bloc) =>
          verify(mockGetAiringTodayTvshows.execute()),
    );
  });

  group('Get on the air tvshows', () {
    test('initial state must be empty', () {
      expect(onTheAirTvshowBloc.state, TvshowLoading());
    });

    blocTest(
      'should emit[loading, tvshowsHasData] when data is gotten succesfully',
      build: () {
        when(mockGetOntheairTvshows.execute())
            .thenAnswer((_) async => Right(testTvshowList));
        return onTheAirTvshowBloc;
      },
      act: (OnTheAirTvshowBloc bloc) => bloc.add(FetchOntheairTvshows()),
      wait: Duration(milliseconds: 500),
      expect: () => [TvshowLoading(), TvshowsHasData(testTvshowList)],
    );

    blocTest(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetOntheairTvshows.execute()).thenAnswer(
            (realInvocation) async => Left(ServerFailure('Server Failure')));
        return onTheAirTvshowBloc;
      },
      act: (OnTheAirTvshowBloc bloc) => bloc.add(FetchOntheairTvshows()),
      wait: Duration(milliseconds: 500),
      expect: () => [
        TvshowLoading(),
        TvshowsError('Server Failure'),
      ],
      verify: (OnTheAirTvshowBloc bloc) =>
          verify(mockGetOntheairTvshows.execute()),
    );
  });

  group('Get popular tvshows', () {
    test('initial state must be empty', () {
      expect(popularTvshowBloc.state, TvshowLoading());
    });

    blocTest(
      'should emit[loading, tvshowsHasData] when data is gotten succesfully',
      build: () {
        when(mockGetPopularTvshows.execute())
            .thenAnswer((_) async => Right(testTvshowList));
        return popularTvshowBloc;
      },
      act: (PopularTvshowBloc bloc) => bloc.add(FetchPopularTvshows()),
      wait: Duration(milliseconds: 500),
      expect: () => [TvshowLoading(), TvshowsHasData(testTvshowList)],
    );

    blocTest(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetPopularTvshows.execute()).thenAnswer(
            (realInvocation) async => Left(ServerFailure('Server Failure')));
        return popularTvshowBloc;
      },
      act: (PopularTvshowBloc bloc) => bloc.add(FetchPopularTvshows()),
      wait: Duration(milliseconds: 500),
      expect: () => [
        TvshowLoading(),
        TvshowsError('Server Failure'),
      ],
      verify: (PopularTvshowBloc bloc) =>
          verify(mockGetPopularTvshows.execute()),
    );
  });

  group('Get top rated tvshows', () {
    test('initial state must be empty', () {
      expect(topRatedTvshowBloc.state, TvshowLoading());
    });

    blocTest(
      'should emit[loading, tvshowsHasData] when data is gotten succesfully',
      build: () {
        when(mockGetTopRatedTvshows.execute())
            .thenAnswer((_) async => Right(testTvshowList));
        return topRatedTvshowBloc;
      },
      act: (TopRatedTvshowBloc bloc) => bloc.add(FetchTopRatedTvshows()),
      wait: Duration(milliseconds: 500),
      expect: () => [TvshowLoading(), TvshowsHasData(testTvshowList)],
    );

    blocTest(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetTopRatedTvshows.execute()).thenAnswer(
            (realInvocation) async => Left(ServerFailure('Server Failure')));
        return topRatedTvshowBloc;
      },
      act: (TopRatedTvshowBloc bloc) => bloc.add(FetchTopRatedTvshows()),
      wait: Duration(milliseconds: 500),
      expect: () => [
        TvshowLoading(),
        TvshowsError('Server Failure'),
      ],
      verify: (TopRatedTvshowBloc bloc) =>
          verify(mockGetTopRatedTvshows.execute()),
    );
  });

  group('Get Recommended tvshows', () {
    test('initial state must be empty', () {
      expect(tvshowRecommendationBloc.state, TvshowLoading());
    });

    blocTest(
      'should emit[loading, tvshowHasData] when data is gotten succesfully',
      build: () {
        when(mockGetTvshowRecommendations.execute(tId))
            .thenAnswer((_) async => Right(testTvshowList));
        return tvshowRecommendationBloc;
      },
      act: (TvshowRecommendationBloc bloc) =>
          bloc.add(FetchTvshowRecommendation(tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [TvshowLoading(), TvshowsHasData(testTvshowList)],
    );

    blocTest(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetTvshowRecommendations.execute(tId)).thenAnswer(
            (realInvocation) async => Left(ServerFailure('Server Failure')));
        return tvshowRecommendationBloc;
      },
      act: (TvshowRecommendationBloc bloc) =>
          bloc.add(FetchTvshowRecommendation(tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        TvshowLoading(),
        const TvshowsError('Server Failure'),
      ],
      verify: (bloc) => verify(mockGetTvshowRecommendations.execute(tId)),
    );
  });

  group('Get Details tvshow', () {
    test('initial state must be empty', () {
      expect(tvshowDetailBloc.state, TvshowLoading());
    });

    blocTest(
      'should emit[loading, tvshowHasData] when data is gotten succesfully',
      build: () {
        when(mockGetTvshowDetail.execute(tId))
            .thenAnswer((_) async => Right(testTvshowDetail));
        return tvshowDetailBloc;
      },
      act: (TvshowDetailBloc bloc) => bloc.add(FetchTvshowDetail(tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [TvshowLoading(), TvshowDetailState(testTvshowDetail)],
    );

    blocTest(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetTvshowDetail.execute(tId)).thenAnswer(
            (realInvocation) async => Left(ServerFailure('Server Failure')));
        return tvshowDetailBloc;
      },
      act: (TvshowDetailBloc bloc) => bloc.add(FetchTvshowDetail(tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        TvshowLoading(),
        const TvshowsError('Server Failure'),
      ],
      verify: (bloc) => verify(mockGetTvshowDetail.execute(tId)),
    );
  });

  group('Get Watchlist tvshows', () {
    test('initial state must be empty', () {
      expect(watchlistTvshowBloc.state, TvshowsEmpty());
    });

    group('Watchlist Tvshows', () {
      test('initial state should be empty', () {
        expect(watchlistTvshowBloc.state, TvshowsEmpty());
      });

      group('Fetch Watchlist Tvshows', () {
        blocTest(
          'Should emit [Loading, HasData] when data is gotten successfully',
          build: () {
            when(mockGetWatchlistTvshows.execute())
                .thenAnswer((_) async => Right(testTvshowList));
            return watchlistTvshowBloc;
          },
          act: (WatchlistTvshowBloc bloc) => bloc.add(FetchWatchlistTvshows()),
          wait: const Duration(milliseconds: 500),
          expect: () => [
            TvshowLoading(),
            WatchlistTvshowsState(testTvshowList),
          ],
          verify: (bloc) => verify(mockGetWatchlistTvshows.execute()),
        );

        blocTest(
          'Should emit [Loading, Error] when get search is unsuccessful',
          build: () {
            when(mockGetWatchlistTvshows.execute())
                .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
            return watchlistTvshowBloc;
          },
          act: (WatchlistTvshowBloc bloc) => bloc.add(FetchWatchlistTvshows()),
          wait: const Duration(milliseconds: 500),
          expect: () => [
            TvshowLoading(),
            const TvshowsError('Server Failure'),
          ],
          verify: (bloc) => verify(mockGetWatchlistTvshows.execute()),
        );
      });
    });
  });

  group('Load Watchlist status Tvshow', () {
    blocTest(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetWatchListStatusTvshow.execute(tId))
            .thenAnswer((_) async => true);
        return watchlistTvshowBloc;
      },
      act: (WatchlistTvshowBloc bloc) => bloc.add(WatchlistTvshowStatus(tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        TvshowLoading(),
        WatchlistTvshowStatusState(true),
      ],
      verify: (bloc) => verify(mockGetWatchListStatusTvshow.execute(tId)),
    );

    blocTest(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetWatchListStatusTvshow.execute(tId))
            .thenAnswer((_) async => false);
        return watchlistTvshowBloc;
      },
      act: (WatchlistTvshowBloc bloc) => bloc.add(WatchlistTvshowStatus(tId)),
      wait: Duration(milliseconds: 500),
      expect: () => [
        TvshowLoading(),
        WatchlistTvshowStatusState(false),
      ],
      verify: (bloc) => verify(mockGetWatchListStatusTvshow.execute(tId)),
    );
  });

  group('Save Watchlist Tvshow', () {
    blocTest(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockSaveWatchlistTvshow.execute(testTvshowDetail)).thenAnswer(
            (_) async => Right(WatchlistTvshowBloc.watchlistAddSuccessMessage));
        return watchlistTvshowBloc;
      },
      act: (WatchlistTvshowBloc bloc) =>
          bloc.add(SaveWatchistTv(testTvshowDetail)),
      wait: Duration(milliseconds: 500),
      expect: () => [
        TvshowLoading(),
        WatchlistTvshowMessage(WatchlistTvshowBloc.watchlistAddSuccessMessage),
      ],
      verify: (bloc) =>
          verify(mockSaveWatchlistTvshow.execute(testTvshowDetail)),
    );

    blocTest(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockSaveWatchlistTvshow.execute(testTvshowDetail))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return watchlistTvshowBloc;
      },
      act: (WatchlistTvshowBloc bloc) =>
          bloc.add(SaveWatchistTv(testTvshowDetail)),
      wait: Duration(milliseconds: 500),
      expect: () => [
        TvshowLoading(),
        TvshowsError('Server Failure'),
      ],
      verify: (bloc) =>
          verify(mockSaveWatchlistTvshow.execute(testTvshowDetail)),
    );
  });

  group('Remove Watchlist Tvshow', () {
    blocTest(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockRemoveWatchlistTvshow.execute(testTvshowDetail)).thenAnswer(
            (_) async => Right(WatchlistTvshowBloc.watchlistAddSuccessMessage));
        return watchlistTvshowBloc;
      },
      act: (WatchlistTvshowBloc bloc) =>
          bloc.add(RemoveWatchlistTvshowEvent(testTvshowDetail)),
      wait: Duration(milliseconds: 500),
      expect: () => [
        TvshowLoading(),
        WatchlistTvshowMessage(WatchlistTvshowBloc.watchlistAddSuccessMessage),
      ],
      verify: (bloc) =>
          verify(mockRemoveWatchlistTvshow.execute(testTvshowDetail)),
    );

    blocTest(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockRemoveWatchlistTvshow.execute(testTvshowDetail))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return watchlistTvshowBloc;
      },
      act: (WatchlistTvshowBloc bloc) =>
          bloc.add(RemoveWatchlistTvshowEvent(testTvshowDetail)),
      wait: Duration(milliseconds: 500),
      expect: () => [
        TvshowLoading(),
        TvshowsError('Server Failure'),
      ],
      verify: (bloc) =>
          verify(mockRemoveWatchlistTvshow.execute(testTvshowDetail)),
    );

    group("search tvshow", () {
      test("initial state should be empty", () {
        expect(searchTvshowBloc.state, SearchEmpty());
      });

      blocTest<SearchTvshowBloc, SearchState>(
          "Should emit [Loading, HasData] when data is gotten successfully",
          build: () {
            when(mockSearchTvshows.execute(tQuery))
                .thenAnswer((_) async => Right(testTvshowList));
            return searchTvshowBloc;
          },
          act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
          wait: const Duration(milliseconds: 500),
          expect: () => [SearchLoading(), SearchHasData(testTvshowList)],
          verify: (bloc) {
            verify(mockSearchTvshows.execute(tQuery));
          });
      blocTest<SearchTvshowBloc, SearchState>(
        'Should emit [Loading, Error] when get search is unsuccessful',
        build: () {
          when(mockSearchTvshows.execute(tQuery))
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return searchTvshowBloc;
        },
        act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
        wait: const Duration(milliseconds: 500),
        expect: () => [
          SearchLoading(),
          SearchError('Server Failure'),
        ],
        verify: (bloc) {
          verify(mockSearchTvshows.execute(tQuery));
        },
      );
    });
  });
}
