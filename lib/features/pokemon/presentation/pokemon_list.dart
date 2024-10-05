import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_riverpod/features/pokemon/data/pokemon_list_provider.dart';

class PokemonListWidget extends ConsumerWidget {
  const PokemonListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(pokemonListProvider);
    return const Placeholder();
  }
}