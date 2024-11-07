import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_riverpod/features/pokemon/data/favourite_pokemon_provider.dart';
import 'package:pokemon_riverpod/features/pokemon/data/pokemon_provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PokemonListItem extends ConsumerStatefulWidget {
  final String name;

  const PokemonListItem({super.key, required this.name});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PokemonListItemWidgetState();
}

class _PokemonListItemWidgetState extends ConsumerState<PokemonListItem> {
  bool _isFavourite = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // print(widget.name);
      // final favouritePokemons = ref.read(favouritePokemonProvider);
      // _isFavourite = favouritePokemons.value?.contains(widget.name) ?? false;
    });
  }

  void _addToFavourite() {
    final provider = ref.read(favouritePokemonProvider.notifier);
    provider.addFavouritePokemon(widget.name);
  }

  void _removeFromFavourite() {
    final provider = ref.read(favouritePokemonProvider.notifier);
    provider.removeFavouritePokemon(widget.name);
  }

  void _onFavouriteIconClick() {
    if (_isFavourite) {
      _removeFromFavourite();
    } else {
      _addToFavourite();
    }
  }

  @override
  Widget build(BuildContext context) {
    final pokemonState = ref.watch(pokemonProvider(widget.name));
    final favouritePokemons = ref.watch(favouritePokemonProvider);
    _isFavourite = favouritePokemons.value?.contains(widget.name) ?? false;

    return Skeletonizer(
      key: ValueKey(widget.name),
      enabled: pokemonState.isLoading,
      child: ListTile(
        leading: SizedBox(
          height: 50,
          width: 50,
          child: CircleAvatar(
            backgroundImage:
                NetworkImage(pokemonState.value?.sprite.frontDefault ?? ''),
            onBackgroundImageError: (exception, stackTrace) =>
                const CircularProgressIndicator(),
          ),
        ),
        title: Text(pokemonState.value?.name.toUpperCase() ?? 'POKEMON'),
        subtitle: Text('Base XP: ${pokemonState.value?.baseExperience}'),
        trailing: InkWell(
          onTap: _onFavouriteIconClick,
          child: Icon(
            _isFavourite
                ? CupertinoIcons.heart_fill
                : CupertinoIcons.heart,
          ),
        ),
      ),
    );
  }
}
