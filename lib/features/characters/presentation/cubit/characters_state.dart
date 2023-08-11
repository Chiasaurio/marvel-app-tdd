part of 'characters_cubit.dart';

abstract class CharactersState extends Equatable {
  const CharactersState();

  @override
  List<Object> get props => [];
}

class Empty extends CharactersState {}

class Loading extends CharactersState {}

class LoadedConcrete extends CharactersState {
  final Character character;

  const LoadedConcrete({required this.character});
  @override
  List<Object> get props => [character];
}

class LoadedList extends CharactersState {
  final List<Character> characters;

  const LoadedList({required this.characters});
  @override
  List<Object> get props => [characters];
}

class Error extends CharactersState {
  final String message;

  const Error({required this.message});
  @override
  List<Object> get props => [message];
}

// class CharactersInitial extends CharactersState {}

// class CharactersSearched extends CharactersState {
//   final String query;
//   final List<Character> characters;
//   final FormStatus status;

//   const CharactersSearched(
//       {required this.query,
//       required this.characters,
//       this.status = FormStatus.noSubmitted});

//   @override
//   List<Object> get props => [query, characters];
// }
