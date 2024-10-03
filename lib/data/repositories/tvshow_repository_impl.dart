import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/data/datasources/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/domain/entities/tvshow.dart';
import 'package:ditonton/domain/entities/tvshow_detail.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/repositories/tvshow_repository.dart';

import '../models/movie_table.dart';

class TvshowRepositoryImpl implements TvshowRepository {
  final MovieRemoteDataSource remoteDataSource;
  final MovieLocalDataSource localDataSource;

  TvshowRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<Tvshow>>> getTvshowAiringTodays() async {
    try {
      final result = await remoteDataSource.getTvshowAiringTodays();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Tvshow>>> getTvshowOntheAir() async {
    try {
      final result = await remoteDataSource.getTvshowOntheAir();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Tvshow>>> getTvshowPopular() async {
    try {
      final result = await remoteDataSource.getTvshowPopular();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Tvshow>>> getTvshowTopRated() async {
    try {
      final result = await remoteDataSource.getTvshowTopRated();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, TvshowDetail>> getTvshowDetail(int id) async {
    try {
      final result = await remoteDataSource.getTvshowDetail(id);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Tvshow>>> getTvshowRecommendations(int id) async {
    try {
      final result = await remoteDataSource.getTvshowRecommendations(id);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Tvshow>>> searchTvshows(String query) async {
    try {
      final result = await remoteDataSource.searchTvshows(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Tvshow>>> getWatchlistTvshows() async {
    final result = await localDataSource.getWatchlistMovies();
    return Right(result.map((data) => data.toEntityTvshow()).toList());
  }

  @override
  Future<bool> isAddedToWatchlist(int id) async {
    final result = await localDataSource.getMovieById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, String>> removeWatchlist(TvshowDetail tvshow) async {
    try {
      final result = await localDataSource
          .removeWatchlist(MovieTable.fromEntityTvshow(tvshow));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<Either<Failure, String>> saveWatchlist(TvshowDetail tvshow) async {
    try {
      final result = await localDataSource
          .insertWatchlist(MovieTable.fromEntityTvshow(tvshow));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      throw e;
    }
  }
}
