import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_riverpod/features/pokemon/data/favourite_pokemon_provider.dart';
import 'package:pokemon_riverpod/features/pokemon/presentation/favourite/favourite_pokemon_list_item.dart';

class FavouritePokemonList extends ConsumerWidget {
  const FavouritePokemonList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favouritePokemons = ref.watch(favouritePokemonProvider);

    return favouritePokemons.when(
      data: (data) {
        return Visibility(
          visible: favouritePokemons.value?.isNotEmpty ?? false,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your Favourites <3',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                SizedBox(
                  height: 120,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: favouritePokemons.value!.length,
                    itemBuilder: (ctx, index) {
                      return FavouritePokemonListItem(
                          name: favouritePokemons.value![index]);
                    },
                    separatorBuilder: (ctx, index) {
                      return const SizedBox(width: 8);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
      loading: () => const Text('loading'),
      error: (err, stackTrace) =>  Text(err.toString()),
    );
  }
}
