import 'package:bia_flutter_test/features/characters/domain/entities/character.dart';
import 'package:bia_flutter_test/features/characters/domain/repositories/characters_repository.dart';
import 'package:bia_flutter_test/features/characters/domain/usecases/get_concrete_character.dart';
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
  late GetConcreteCharacter usecase;
  late MockCharactersRepository mockCharactersRepository;

  setUp(() {
    mockCharactersRepository = MockCharactersRepository();
    usecase = GetConcreteCharacter(mockCharactersRepository);
  });
  const tNumber = 1017100;
  const tConcreteCharacter = Character(
      name: "A-Bomb (HAS)",
      thumbnail: "http://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16",
      description:
          "Rick Jones has been Hulk's best bud since day one, but now he's more than a friend...he's a teammate! Transformed by a Gamma energy explosion, A-Bomb's thick, armored skin is just as strong and powerful as it is blue. And when he curls into action, he uses it like a giant bowling ball of destruction!.");

  test(
    'Should get Character for the given id from repository',
    () async {
      // "On the fly" implementation of the Repository using the Mockito package.
      //When getConcreteCharacter is called with any argument, always answer with
      // the Right "side" of Either containing a test Character object.
      when(() => mockCharactersRepository.getConcreteCharacter(any()))
          .thenAnswer((_) async => const Right(tConcreteCharacter));
      // The "act" phase of the test. Call the not-yet-existent method.
      final result = await usecase(const ConcreteParams(number: tNumber));
      // UseCase should simply return whatever was returned from the Repository
      expect(result, const Right(tConcreteCharacter));
      // Verify that the method has been called on the Repository
      verify(() => mockCharactersRepository.getConcreteCharacter(tNumber));
      // Only the above method should be called and nothing more.
      verifyNoMoreInteractions(mockCharactersRepository);
    },
  );
}
