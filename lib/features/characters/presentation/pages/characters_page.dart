import 'package:bia_flutter_test/features/characters/presentation/cubit/characters_cubit.dart';
import 'package:bia_flutter_test/features/characters/presentation/widgets/character_preview.dart';
import 'package:bia_flutter_test/features/characters/presentation/widgets/search_bar.dart';
import 'package:bia_flutter_test/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharactersPage extends StatelessWidget {
  const CharactersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        title: const Text('Personajes de Marvel'),
      ),
      body: BlocProvider(
        create: (context) => sl<CharactersCubit>(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            SearchBar(),
            CharactersPreview(),
          ],
        ),
      ),
    );
  }
}
