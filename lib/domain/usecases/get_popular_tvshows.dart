import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tvshow.dart';
import 'package:ditonton/domain/repositories/tvshow_repository.dart';

import '../../common/failure.dart';

class GetPopularTvshows {
  final TvshowRepository repository;

  GetPopularTvshows(this.repository);

  Future<Either<Failure, List<Tvshow>>> execute() {
    return repository.getTvshowPopular();
  }
}
