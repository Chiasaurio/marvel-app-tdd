import 'package:bia_flutter_test/core/error/failure.dart';
import 'package:bia_flutter_test/features/characters/data/models/character_model.dart';
import 'package:bia_flutter_test/features/characters/domain/entities/character.dart';
import 'package:bia_flutter_test/features/characters/domain/usecases/get_concrete_character.dart';
import 'package:bia_flutter_test/features/characters/domain/usecases/get_list_of_characters.dart';
import 'package:bia_flutter_test/features/characters/presentation/cubit/characters_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetConcreteCharacter extends Mock implements GetConcreteCharacter {}

class MockGetListOfCharacters extends Mock implements GetListOfCharacters {}

void main() {
  late CharactersCubit bloc;
  late MockGetConcreteCharacter mockGetConcreteCharacter;
  late MockGetListOfCharacters mockGetListOfCharacters;

  setUp(() {
    mockGetConcreteCharacter = MockGetConcreteCharacter();
    mockGetListOfCharacters = MockGetListOfCharacters();
    registerFallbackValue(const ConcreteParams(number: 0));
    registerFallbackValue(const CharacterListParams(nameStarsWith: ''));
    bloc = CharactersCubit(
      concrete: mockGetConcreteCharacter,
      list: mockGetListOfCharacters,
    );
  });

  test('initialState should be Empty', () {
    // assert
    expect(bloc.state, equals(Empty()));
  });

  group('GetConcreteCharacter', () {
    // The event takes in a String
    const tCharacterId = 1009157;
    // NumberTrivia instance is needed too, of course
    const tCharacterModel = CharacterModel(
        name: "Spider-Girl (Anya Corazon)",
        description: " ",
        thumbnail: "http://i.annihil.us/u/prod/marvel/i/mg/a/10/528d369de3e4f");

    test(
      'should get data from the concrete use case',
      () async {
        // arrange
        when(() => mockGetConcreteCharacter(any()))
            .thenAnswer((_) async => const Right(tCharacterModel));
        // act
        bloc.getCharacterFromId(tCharacterId);
        await untilCalled(() => mockGetConcreteCharacter(any()));
        // assert
        verify(() => mockGetConcreteCharacter(
            const ConcreteParams(number: tCharacterId)));
      },
    );

    test(
      'should emit [Loading, Loaded] when data is gotten successfully',
      () async {
        // arrange
        when(() => mockGetConcreteCharacter(any()))
            .thenAnswer((_) async => const Right(tCharacterModel));
        // assert later
        final expected = [
          Loading(),
          const LoadedConcrete(character: tCharacterModel),
        ];
        expectLater(bloc.stream, emitsInOrder(expected));
        // act
        bloc.getCharacterFromId(tCharacterId);
      },
    );

    test(
      'should emit [Loading, Error] when getting data fails',
      () async {
        // arrange
        when(() => mockGetConcreteCharacter(any()))
            .thenAnswer((_) async => Left(ServerFailure()));
        // assert later
        const String serverFailureMessage = 'Server Failure';
        final expected = [
          Loading(),
          const Error(message: serverFailureMessage),
        ];
        expectLater(bloc.stream, emitsInOrder(expected));
        // act
        bloc.getCharacterFromId(tCharacterId);
      },
    );
  });

  group('GetListCharacters', () {
    // The event takes in a String
    const tNameStarsWith = '';
    const tCharacters = <Character>[
      CharacterModel(
          name: "Spider-Girl (Anya Corazon)",
          description: " ",
          thumbnail:
              "http://i.annihil.us/u/prod/marvel/i/mg/a/10/528d369de3e4f")
    ];
    // NumberTrivia instance is needed too, of course

    test(
      'should get data from the concrete use case',
      () async {
        // arrange
        when(() => mockGetListOfCharacters(any()))
            .thenAnswer((_) async => const Right(tCharacters));
        // act
        bloc.getCharacterList(tNameStarsWith);
        await untilCalled(() => mockGetListOfCharacters(any()));
        // assert
        verify(() => mockGetListOfCharacters(
            const CharacterListParams(nameStarsWith: tNameStarsWith)));
      },
    );

    test(
      'should emit [Loading, Loaded] when data is gotten successfully',
      () async {
        // arrange
        when(() => mockGetListOfCharacters(any()))
            .thenAnswer((_) async => const Right(tCharacters));
        // assert later
        final expected = [
          Loading(),
          const LoadedList(characters: tCharacters),
        ];
        expectLater(bloc.stream, emitsInOrder(expected));
        // act
        bloc.getCharacterList(tNameStarsWith);
      },
    );

    test(
      'should emit [Loading, Error] when getting data fails',
      () async {
        // arrange
        when(() => mockGetListOfCharacters(any()))
            .thenAnswer((_) async => Left(ServerFailure()));
        // assert later
        const String serverFailureMessage = 'Server Failure';
        final expected = [
          Loading(),
          const Error(message: serverFailureMessage),
        ];
        expectLater(bloc.stream, emitsInOrder(expected));
        // act
        bloc.getCharacterList(tNameStarsWith);
      },
    );
  });
}
