import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_riverpod/core/async_value_ui.dart';
import 'package:pokemon_riverpod/features/pokemon/data/pokemon_list_provider.dart';
import 'package:pokemon_riverpod/features/pokemon/presentation/pokemon_list_item.dart';

class PokemonListWidget extends ConsumerStatefulWidget {
  const PokemonListWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PokemonListWidgetState();
}

class _PokemonListWidgetState extends ConsumerState<PokemonListWidget> {
  final ScrollController _scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scroll.addListener(_scrollListener);
    });
  }

  @override
  void dispose() {
    _scroll.removeListener(_scrollListener);
    _scroll.dispose();
    super.dispose();
  }

  void _scrollListener() {
    // reach the end of list, auto load the next page
    if (_scroll.offset > _scroll.position.maxScrollExtent * 0.8 && !_scroll.position.outOfRange) {
      ref.read(pokemonListProvider.notifier).getPokemons();
    }
  }

  @override
  Widget build(BuildContext context) {
    final pokemonListState = ref.watch(pokemonListProvider);

    ref.listen(pokemonListProvider, (_, state) {
      state.showSnackbarOnError(context);
    });

    return pokemonListState.when(
      data: (data) {
        return ListView.builder(
          controller: _scroll,
          itemCount: data.results?.length ?? 0,
          itemBuilder: (ctx, index) {
            final pokemonListItem = data.results?[index];
            return PokemonListItem(url: pokemonListItem?.url ?? '');
          },
        );
      },
      error: (err, stackTrace) {
        return Container();
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
