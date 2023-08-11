import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/character.dart';

abstract class CharactersRepository {
  Future<Either<Failure, List<Character>>> getListOfCharacters(
      String nameStarsWith);
  Future<Either<Failure, Character>> getConcreteCharacter(int id);
}
