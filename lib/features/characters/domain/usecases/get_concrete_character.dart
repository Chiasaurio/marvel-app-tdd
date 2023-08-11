import 'package:bia_flutter_test/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../entities/character.dart';
import '../repositories/characters_repository.dart';

class GetConcreteCharacter extends UseCase<Character, Params> {
  final CharactersRepository repository;

  GetConcreteCharacter(this.repository);

  @override
  Future<Either<Failure, Character>> call(Params params) async {
    return await repository.getConcreteCharacter(params.number);
  }
}

class Params extends Equatable {
  final int number;

  const Params({required this.number});

  @override
  List<Object?> get props => [number];
}
