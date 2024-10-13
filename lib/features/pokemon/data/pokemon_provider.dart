import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_riverpod/core/app_database.dart';
import 'package:pokemon_riverpod/core/network/api.dart';
import 'package:pokemon_riverpod/core/locator.dart';
import 'package:pokemon_riverpod/core/network/api_routes.dart';
import 'package:pokemon_riverpod/features/pokemon/data/local/pokemon_local.dart';
import 'package:pokemon_riverpod/features/pokemon/domain/pokemon.dart';

final pokemonProvider =
    FutureProvider.autoDispose.family<Pokemon?, String>((ref, name) async {
  final api = locator.get<Api>();
  final db = locator.get<AppDatabase>();

  // use locally cached data if there is any
  PokemonLocal? local = await db.pokemonDao.findPokemonByName(name);
  if (local != null) {
    return Pokemon.fromLocal(local);
  } else {
    final response = await api.get(endpoint: ApiRoutes.getPokemon(name));

    if (response != null && response.data != null) {
      final pokemon = Pokemon.fromJson(response.data);
      final lPokemon = PokemonLocal.fromPokemon(pokemon);
      try {
        await db.pokemonDao.insertPokemon(lPokemon);
      } catch (e) {
        debugPrint(e.toString());
      }
      return pokemon;
    }
  }

  return null;
});
