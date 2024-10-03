import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../entities/tvshow.dart';
import '../entities/tvshow_detail.dart';

abstract class TvshowRepository {
  Future<Either<Failure, List<Tvshow>>> getTvshowAiringTodays();
  Future<Either<Failure, List<Tvshow>>> getTvshowOntheAir();
  Future<Either<Failure, List<Tvshow>>> getTvshowPopular();
  Future<Either<Failure, List<Tvshow>>> getTvshowTopRated();

  Future<Either<Failure, TvshowDetail>> getTvshowDetail(int id);
  Future<Either<Failure, List<Tvshow>>> getTvshowRecommendations(int id);
  Future<Either<Failure, List<Tvshow>>> searchTvshows(String query);

  // local
  Future<Either<Failure, String>> saveWatchlist(TvshowDetail tvshow);
  Future<Either<Failure, String>> removeWatchlist(TvshowDetail tvshow);
  Future<bool> isAddedToWatchlist(int id);
  Future<Either<Failure, List<Tvshow>>> getWatchlistTvshows();
}
