import 'package:bia_flutter_test/features/characters/domain/entities/character.dart';

class CharacterModel extends Character {
  const CharacterModel(
      {required super.name,
      required super.thumbnail,
      required super.description});

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
        name: json['name'],
        thumbnail: json['thumbnail']['path'],
        description: json['description']);
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'thumbnail': thumbnail, 'description': description};
  }
}
