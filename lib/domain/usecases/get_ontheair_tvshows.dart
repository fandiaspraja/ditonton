import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tvshow.dart';
import 'package:ditonton/domain/repositories/tvshow_repository.dart';

import '../../common/failure.dart';

class GetOntheairTvshows {
  final TvshowRepository repository;

  GetOntheairTvshows(this.repository);

  Future<Either<Failure, List<Tvshow>>> execute() {
    return repository.getTvshowOntheAir();
  }
}
