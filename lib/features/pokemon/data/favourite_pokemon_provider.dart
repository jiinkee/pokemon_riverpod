import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_riverpod/core/app_shared_prefs.dart';

class FavouritePokemonNotifier extends AsyncNotifier<List<String>> {
  static const favouritePokemons = 'favourite_pokemons';

  @override
  FutureOr<List<String>> build() async {
    return AppSharedPrefs.getStringList(favouritePokemons);
  }

  Future<void> addFavouritePokemon(String name) async {
    List<String> newList = [...?state.value, name];
    state = AsyncValue.data(newList);
    await AppSharedPrefs.setStringList(favouritePokemons, newList);
  }

  Future<void> removeFavouritePokemon(String name) async {
    if (state.value != null) {
      List<String> newList = state.value!.where((p) => p != name).toList();
      state = AsyncValue.data(newList);
      await AppSharedPrefs.setStringList(favouritePokemons, newList);
    }
  }
}

final favouritePokemonProvider =
    AsyncNotifierProvider<FavouritePokemonNotifier, List<String>>(() {
  return FavouritePokemonNotifier();
});
