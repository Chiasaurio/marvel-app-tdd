import 'package:bia_flutter_test/core/error/exception.dart';
import 'package:bia_flutter_test/features/characters/data/datasources/characters_remote_data_source.dart';
import 'package:bia_flutter_test/features/characters/data/models/character_model.dart';
import 'package:bia_flutter_test/features/characters/domain/entities/character.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late CharactersRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = CharactersRemoteDataSourceImpl(client: mockHttpClient);
    registerFallbackValue(Uri.parse(""));
  });

  void setUpMockHttpClientSuccess200() {
    when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
        .thenAnswer(
      (_) async => http.Response(fixture('character.json'), 200),
    );
  }

  void setUpMockHttpClientFailure404() {
    when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
        .thenAnswer(
      (_) async => http.Response('Something went wrong', 404),
    );
  }

  group('getConcreteCharacter', () {
    const tCharacterId = 1009157;
    const tCharacterModel = CharacterModel(
        name: "Spider-Girl (Anya Corazon)",
        description: " ",
        thumbnail: "http://i.annihil.us/u/prod/marvel/i/mg/a/10/528d369de3e4f");
    const Character tCharacter = tCharacterModel;

    test(
      'should preform a GET request on a URL with number being the endpoint and with application/json header',
      () {
        //arrange
        setUpMockHttpClientSuccess200();
        // act
        dataSource.getConcreteCharacter(tCharacterId);
        // assert
        verify(() => mockHttpClient.get(
              Uri.parse(
                  'https://gateway.marvel.com:443/v1/public/characters/$tCharacterId?apikey=f895e99c45718984ca48eea529daa825&hash=d0c8e7dd10d2ab762c33143d818cf03b&ts=10000'),
              headers: {'Content-Type': 'application/json'},
            ));
      },
    );

    test(
      'should return Character when the response code is 200 (success)',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();

        // act
        final result = await dataSource.getConcreteCharacter(tCharacterId);
        // assert
        expect(result, equals(tCharacterModel));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpMockHttpClientFailure404();
        // act
        final call = dataSource.getConcreteCharacter;
        // assert
        expect(() => call(tCharacterId),
            throwsA(const TypeMatcher<ServerException>()));
      },
    );
  });

  group('getListCharacters', () {
    const tCharacterStartsWith = "";
    const tListCharacters = <CharacterModel>[
      CharacterModel(
          name: "Spider-Girl (Anya Corazon)",
          description: " ",
          thumbnail:
              "http://i.annihil.us/u/prod/marvel/i/mg/a/10/528d369de3e4f")
    ];

    test(
      'should preform a GET request on a URL with number being the endpoint and with application/json header',
      () {
        //arrange
        setUpMockHttpClientSuccess200();
        // act
        dataSource.getListOfCharacters(tCharacterStartsWith);
        // assert
        verify(() => mockHttpClient.get(
              Uri.parse(
                  'https://gateway.marvel.com:443/v1/public/characters?apikey=f895e99c45718984ca48eea529daa825&hash=d0c8e7dd10d2ab762c33143d818cf03b&ts=10000&nameStartsWith=$tCharacterStartsWith'),
              headers: {'Content-Type': 'application/json'},
            ));
      },
    );

    test(
      'should return Character when the response code is 200 (success)',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();

        // act
        final result =
            await dataSource.getListOfCharacters(tCharacterStartsWith);
        // assert
        expect(result, equals(tListCharacters));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpMockHttpClientFailure404();
        // act
        final call = dataSource.getListOfCharacters;
        // assert
        expect(() => call(tCharacterStartsWith),
            throwsA(const TypeMatcher<ServerException>()));
      },
    );
  });
}
