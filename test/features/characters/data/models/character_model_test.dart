import 'dart:convert';

import 'package:bia_flutter_test/features/characters/data/models/character_model.dart';
import 'package:bia_flutter_test/features/characters/domain/entities/character.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tCharacterModel = CharacterModel(
      name: "Spider-Girl (Anya Corazon)",
      thumbnail: "http://i.annihil.us/u/prod/marvel/i/mg/a/10/528d369de3e4f",
      description: " ");

  test(
    'should be a subclass of Character entity',
    () async {
      // assert
      expect(tCharacterModel, isA<Character>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid model from the JSON',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('character.json'))["data"]["results"][0];
        // act
        final result = CharacterModel.fromJson(jsonMap);
        // assert
        expect(result, tCharacterModel);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // act
        final result = tCharacterModel.toJson();
        // assert
        final expectedJsonMap = {
          "name": "Spider-Girl (Anya Corazon)",
          "thumbnail":
              "http://i.annihil.us/u/prod/marvel/i/mg/a/10/528d369de3e4f",
          "description": " "
        };
        expect(result, expectedJsonMap);
      },
    );
  });
}
