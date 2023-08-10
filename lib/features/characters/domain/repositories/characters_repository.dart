import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/character.dart';

abstract class CharactersRepository {
  Future<Either<Failure, List<Character>>> getListOfCharacters();
  Future<Either<Failure, Character>> getConcreteCharacter(int id);
}
