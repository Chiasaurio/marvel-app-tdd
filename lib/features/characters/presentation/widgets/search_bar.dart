import 'package:bia_flutter_test/features/characters/presentation/cubit/characters_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: TextField(
            autofocus: false,
            onChanged: (value) {
              BlocProvider.of<CharactersCubit>(context).getCharacterList(value);
            },
            cursorColor: Colors.white70,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
            decoration: InputDecoration(
              suffixIcon: const Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: Icon(
                  Icons.search,
                  color: Colors.white70,
                ),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              hintText: '¿Que personaje deseas buscar?',
              hintStyle: const TextStyle(fontSize: 16, color: Colors.white70),
              filled: true,
              fillColor: Theme.of(context).colorScheme.primary,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none),
            ),
          ),
        ),
      ],
    );
  }
}
