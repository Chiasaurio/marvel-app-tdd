import 'package:equatable/equatable.dart';

class Character extends Equatable {
  final String name;
  final String thumbnail;
  final String description;

  const Character(
      {required this.name, required this.thumbnail, required this.description});

  @override
  List<Object?> get props => [name, thumbnail, description];
}
