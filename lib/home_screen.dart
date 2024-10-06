import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_riverpod/core/async_value_ui.dart';
import 'package:pokemon_riverpod/features/pokemon/data/pokemon_list_provider.dart';
import 'package:pokemon_riverpod/features/pokemon/presentation/pokemon_list_item.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemonListState = ref.watch(pokemonListProvider);

    ref.listen(pokemonListProvider, (_, state) {
      state.showSnackbarOnError(context);
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokemon'),
      ),
      body: pokemonListState.when(
        data: (data) {
          return ListView.builder(
            itemCount: data.results?.length,
            itemBuilder: (ctx, index) {
              final pokemonListItem = data.results?[index];
              return PokemonListItem(url: pokemonListItem?.url ?? '');
            },
          );
        },
        error: (err, stackTrace) {
          return null;
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
