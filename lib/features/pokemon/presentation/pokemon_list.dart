import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_riverpod/core/extensions/async_value_ui.dart';
import 'package:pokemon_riverpod/features/pokemon/data/pokemon_list_provider.dart';
import 'package:pokemon_riverpod/features/pokemon/presentation/pokemon_list_item.dart';
import 'package:pokemon_riverpod/features/pokemon/presentation/pokemon_list_item_skeleton.dart';

class PokemonListWidget extends ConsumerStatefulWidget {
  const PokemonListWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PokemonListWidgetState();
}

class _PokemonListWidgetState extends ConsumerState<PokemonListWidget> {
  final ScrollController _scroll = ScrollController();
  // need to keep track of this to prevent api spamming for infinite loading
  bool _loadMore = false;

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
    final pokemonListNotifer = ref.read(pokemonListProvider.notifier);

    if (!_loadMore &&
        _scroll.offset > _scroll.position.maxScrollExtent * 0.7 &&
        !_scroll.position.outOfRange) {
      _loadMore = true;
      pokemonListNotifer.getPokemons().then((_) {
        _loadMore = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // final pokemonListState = ref.watch(pokemonListProvider);

    ref.listen(pokemonListProvider, (_, state) {
      state.showSnackbarOnError(context);
    });

    return ListView.builder(
      controller: _scroll,
      itemBuilder: (ctx, index) {
        final pokemonListState = ref.watch(pokemonListProvider);
        return pokemonListState.when(
          data: (data) {
            int totalItems = data.results?.length ?? 0;
            if (index >= totalItems && index <= totalItems + 3) {
              return const PokemonListItemSkeleton();
            } else if (index >= totalItems) {
              return null;
            }
            return PokemonListItem(name: data.results?[index].name ?? '');
          },
          error: (err, stackTrace) {
            return const SizedBox.shrink();
          },
          loading: () => const PokemonListItemSkeleton(),
        );
      },
    );

    // return pokemonListState.when(
    //   data: (data) {
    //     return ListView.builder(
    //       controller: _scroll,
    //       itemCount: (data.results?.length ?? 0) + 3,
    //       itemBuilder: (ctx, index) {
    //         final pokemonListItem = data.results?[index];
    //         return PokemonListItem(
    //           name: pokemonListItem?.name ?? '',
    //           showSkeleton: index >= (data.results?.length ?? 0),
    //         );
    //       },
    //     );
    //   },
    //   error: (err, stackTrace) {
    //     return Container();
    //   },
    //   loading: () => const Center(
    //     child: CircularProgressIndicator(),
    //   ),
    // );
  }
}
