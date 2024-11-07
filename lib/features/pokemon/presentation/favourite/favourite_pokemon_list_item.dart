import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_riverpod/features/pokemon/data/pokemon_provider.dart';

class FavouritePokemonListItem extends ConsumerWidget {
  final String name;
  const FavouritePokemonListItem({super.key, required this.name});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemonState = ref.watch(pokemonProvider(name));

    return Container(
      decoration: BoxDecoration(
        color: Colors.green.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      height: 120,
      width: 100,
      child: pokemonState.when(
        data: (data) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
            child: Column(
              children: [
                Image.network(
                  data?.sprite.frontDefault ?? '',
                  height: 80,
                  width: 80,
                ),
                Expanded(
                  child: Text(
                    name.toUpperCase(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const CircularProgressIndicator(),
        error: (err, stackTrace) => null,
      ),
    );
  }
}
