import 'package:bia_flutter_test/core/usecases/usecase.dart';
import 'package:bia_flutter_test/features/characters/domain/usecases/get_concrete_character.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../entities/character.dart';
import '../repositories/characters_repository.dart';

class GetListOfCharacters
    extends UseCase<List<Character>, CharacterListParams> {
  final CharactersRepository repository;

  GetListOfCharacters(this.repository);

  @override
  Future<Either<Failure, List<Character>>> call(
      CharacterListParams params) async {
    return await repository.getListOfCharacters(params.nameStarsWith);
  }
}

class CharacterListParams extends Equatable {
  final String nameStarsWith;

  const CharacterListParams({required this.nameStarsWith});

  @override
  List<Object?> get props => [nameStarsWith];
}
