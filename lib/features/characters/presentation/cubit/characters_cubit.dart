import 'package:bia_flutter_test/features/characters/domain/entities/character.dart';
import 'package:bia_flutter_test/features/characters/domain/usecases/get_concrete_character.dart';
import 'package:bia_flutter_test/features/characters/domain/usecases/get_list_of_characters.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final GetConcreteCharacter getConcreteCharacter;
  final GetListOfCharacters getListOfCharacters;

  final String SERVER_FAILURE_MESSAGE = 'Server Failure';

  CharactersCubit(
      {required GetConcreteCharacter concrete,
      required GetListOfCharacters list})
      : getConcreteCharacter = concrete,
        getListOfCharacters = list,
        super(Empty());

  Future<void> getCharacterFromId(int id) async {
    emit(Loading());
    final failureOrCharacter =
        await getConcreteCharacter(ConcreteParams(number: id));
    emit(failureOrCharacter.fold(
        (failure) => Error(message: SERVER_FAILURE_MESSAGE),
        (character) => LoadedConcrete(character: character)));
  }

  Future<void> getCharacterList(String name) async {
    emit(Loading());
    final failureOrCharacters =
        await getListOfCharacters(CharacterListParams(nameStarsWith: name));
    emit(failureOrCharacters.fold(
        (failure) => Error(message: SERVER_FAILURE_MESSAGE),
        (characters) => LoadedList(characters: characters)));
  }
}
