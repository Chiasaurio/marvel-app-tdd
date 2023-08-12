import 'package:bia_flutter_test/features/characters/presentation/cubit/characters_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharactersPreview extends StatelessWidget {
  const CharactersPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 300),
      child: Center(
        child: BlocBuilder<CharactersCubit, CharactersState>(
          builder: (context, state) {
            if (state is LoadedList) {
              return const Text('Lista');
            } else if (state is Loading) {
              return const Text('Start searching!');
            } else {
              return const Text('Start searching!');
            }
          },
        ),
      ),
    );
  }
}
