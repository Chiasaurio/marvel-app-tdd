import 'dart:convert';

import 'package:bia_flutter_test/features/characters/data/models/character_model.dart';
import 'package:http/http.dart' as http;

import '../../../../core/error/exception.dart';

abstract class CharactersRemoteDataSource {
  /// Calls the https://gateway.marvel.com:443/v1/public/characters/{id} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<CharacterModel> getConcreteCharacter(int id);

  /// Calls the https://gateway.marvel.com:443/v1/public/characters/ endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<CharacterModel>> getListOfCharacters(String nameStarsWith);
}

class CharactersRemoteDataSourceImpl implements CharactersRemoteDataSource {
  final http.Client client;

  CharactersRemoteDataSourceImpl({required this.client});

  @override
  Future<CharacterModel> getConcreteCharacter(int id) => _getCharacterFromUrl(
      'https://gateway.marvel.com:443/v1/public/characters/$id?apikey=f895e99c45718984ca48eea529daa825&hash=d0c8e7dd10d2ab762c33143d818cf03b&ts=10000');

  @override
  Future<List<CharacterModel>> getListOfCharacters(String nameStarsWith) =>
      _getListOfCharactersFromUrl(
          'https://gateway.marvel.com:443/v1/public/characters?apikey=f895e99c45718984ca48eea529daa825&hash=d0c8e7dd10d2ab762c33143d818cf03b&ts=10000&nameStartsWith=$nameStarsWith');

  Future<CharacterModel> _getCharacterFromUrl(String url) async {
    final response = await client.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return CharacterModel.fromJson(
          json.decode(response.body)["data"]["results"][0]);
    } else {
      throw ServerException();
    }
  }

  Future<List<CharacterModel>> _getListOfCharactersFromUrl(String url) async {
    final response = await client.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> respDecoded =
          json.decode(response.body)["data"]["results"];
      return respDecoded.map((e) => CharacterModel.fromJson(e)).toList();
    } else {
      throw ServerException();
    }
  }
}
