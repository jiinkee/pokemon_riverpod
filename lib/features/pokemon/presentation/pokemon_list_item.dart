import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_riverpod/features/pokemon/data/pokemon_provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PokemonListItem extends ConsumerWidget {
  final String url;

  const PokemonListItem({super.key, required this.url});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemonState = ref.watch(pokemonProvider(url));

    return Skeletonizer(
      key: ValueKey(url),
      enabled: pokemonState.isLoading,
      child: ListTile(
        leading: SizedBox(
          height: 50,
          width: 50,
          child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      pokemonState.value?.sprite.frontDefault ?? ''),
                  onBackgroundImageError: (exception, stackTrace) =>
                      const CircularProgressIndicator(),
                ),
        ),
        title: Text(pokemonState.value?.name.toUpperCase() ?? 'POKEMON'),
        subtitle: Text('Base XP: ${pokemonState.value?.baseExperience}'),
      ),
    );
  }
}