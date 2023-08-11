import 'package:bia_flutter_test/core/error/failure.dart';
import 'package:bia_flutter_test/core/usecases/usecase.dart';
import 'package:bia_flutter_test/features/characters/domain/entities/character.dart';
import 'package:bia_flutter_test/features/characters/domain/repositories/characters_repository.dart';
import 'package:bia_flutter_test/features/characters/domain/usecases/get_list_of_characters.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCharactersRepository extends Mock implements CharactersRepository {
  // @override
  // Future<Either<Failure, List<Character>>> getListOfCharacters() async {
  //   return const Right(<Character>[]);
  // }
}

void main() {
  late GetListOfCharacters usecase;
  late MockCharactersRepository mockCharactersRepository;

  setUp(() {
    mockCharactersRepository = MockCharactersRepository();
    usecase = GetListOfCharacters(mockCharactersRepository);
  });
  const tNameStarsWith = '';
  final tCharacters = <Character>[];
  // const tConcreteCharacter =  Character(name: "A-Bomb (HAS)", thumbnail: "http://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16", description: "Rick Jones has been Hulk's best bud since day one, but now he's more than a friend...he's a teammate! Transformed by a Gamma energy explosion, A-Bomb's thick, armored skin is just as strong and powerful as it is blue. And when he curls into action, he uses it like a giant bowling ball of destruction!.")

  test(
    'Should get the Characters list from repository',
    () async {
      // "On the fly" implementation of the Repository using the Mockito package.
      // When getListOfCharacters, always answer with
      // the Right "side" of Either containing a List of Character objects.
      when(() => mockCharactersRepository.getListOfCharacters(any()))
          .thenAnswer((_) async => Right(tCharacters));
      // The "act" phase of the test. Call the not-yet-existent method.
      final result = await usecase(
          const CharacterListParams(nameStarsWith: tNameStarsWith));
      // UseCase should simply return whatever was returned from the Repository
      expect(result, Right(tCharacters));
      // Verify that the method has been called on the Repository
      verify(
          () => mockCharactersRepository.getListOfCharacters(tNameStarsWith));
      // Only the above method should be called and nothing more.
      verifyNoMoreInteractions(mockCharactersRepository);
    },
  );
}
