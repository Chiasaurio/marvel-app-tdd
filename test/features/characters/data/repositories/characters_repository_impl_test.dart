import 'package:bia_flutter_test/core/error/exception.dart';
import 'package:bia_flutter_test/core/error/failure.dart';
import 'package:bia_flutter_test/core/network/network_info.dart';
import 'package:bia_flutter_test/features/characters/data/datasources/characters_remote_data_source.dart';
import 'package:bia_flutter_test/features/characters/data/models/character_model.dart';
import 'package:bia_flutter_test/features/characters/data/repositories/characters_repository_impl.dart';
import 'package:bia_flutter_test/features/characters/domain/entities/character.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRemoteDataSource extends Mock implements CharactersRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late CharactersRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = CharactersRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('getConcreteCharacter', () {
    const tCharacterId = 1009157;
    const tCharacterModel = CharacterModel(
        name: "Spider-Girl (Anya Corazon)",
        description: " ",
        thumbnail: "http://i.annihil.us/u/prod/marvel/i/mg/a/10/528d369de3e4f");
    const Character tCharacter = tCharacterModel;
    test(
      'should check if the device is online',
      () async {
        // arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(() => mockRemoteDataSource.getConcreteCharacter(any()))
            .thenAnswer((_) async => tCharacterModel);
        // act
        repository.getConcreteCharacter(tCharacterId);
        // assert
        verify(() => mockNetworkInfo.isConnected);
      },
    );

    runTestsOnline(() {
      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          when(() => mockRemoteDataSource.getConcreteCharacter(tCharacterId))
              .thenAnswer((_) async => tCharacterModel);
          // act
          final result = await repository.getConcreteCharacter(tCharacterId);
          // assert
          verify(() => mockRemoteDataSource.getConcreteCharacter(tCharacterId));
          expect(result, equals(const Right(tCharacterModel)));
        },
      );

      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(() => mockRemoteDataSource.getConcreteCharacter(tCharacterId))
              .thenThrow(ServerException());
          // act
          final result = await repository.getConcreteCharacter(tCharacterId);
          // assert
          verify(() => mockRemoteDataSource.getConcreteCharacter(tCharacterId));
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });

    runTestsOffline(() {
      test(
        'should return network failure',
        () async {
          // act
          final result = await repository.getConcreteCharacter(tCharacterId);
          // assert
          verifyZeroInteractions(mockRemoteDataSource);
          expect(result, equals(Left(NetworkFailure())));
        },
      );
    });
  });

  group('getListCharacters', () {
    const tCharacterStartsWith = "";
    const tListCharacters = <CharacterModel>[];
    test(
      'should check if the device is online',
      () async {
        // arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(() => mockRemoteDataSource.getListOfCharacters(any()))
            .thenAnswer((_) async => tListCharacters);
        // act
        repository.getListOfCharacters(tCharacterStartsWith);
        // assert
        verify(() => mockNetworkInfo.isConnected);
      },
    );

    runTestsOnline(() {
      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          when(() => mockRemoteDataSource.getListOfCharacters(
              tCharacterStartsWith)).thenAnswer((_) async => tListCharacters);
          // act
          final result =
              await repository.getListOfCharacters(tCharacterStartsWith);
          // assert
          verify(() =>
              mockRemoteDataSource.getListOfCharacters(tCharacterStartsWith));
          expect(result, equals(const Right(tListCharacters)));
        },
      );

      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(() => mockRemoteDataSource.getListOfCharacters(
              tCharacterStartsWith)).thenThrow(ServerException());
          // act
          final result =
              await repository.getListOfCharacters(tCharacterStartsWith);
          // assert
          verify(() =>
              mockRemoteDataSource.getListOfCharacters(tCharacterStartsWith));
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });

    runTestsOffline(() {
      test(
        'should return network failure',
        () async {
          // act
          final result =
              await repository.getListOfCharacters(tCharacterStartsWith);
          // assert
          verifyZeroInteractions(mockRemoteDataSource);
          expect(result, equals(Left(NetworkFailure())));
          // verify(mockLocalDataSource.getLastNumberTrivia());
          // expect(result, equals(Right(tNumberTrivia)));
        },
      );
    });
  });
}
