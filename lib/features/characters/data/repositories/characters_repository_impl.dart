import 'package:bia_flutter_test/features/characters/domain/entities/character.dart';
import 'package:bia_flutter_test/core/error/failure.dart';
import 'package:bia_flutter_test/features/characters/domain/repositories/characters_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/platform/network_info.dart';
import '../datasources/characters_remote_data_source.dart';

class CharactersRepositoryImpl implements CharactersRepository {
  final CharactersRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  CharactersRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, Character>> getConcreteCharacter(int id) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await remoteDataSource.getConcreteCharacter(id));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<Character>>> getListOfCharacters(
      String nameStarsWith) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await remoteDataSource.getListOfCharacters(nameStarsWith));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
