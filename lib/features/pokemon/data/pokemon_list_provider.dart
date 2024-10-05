import 'dart:async';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_riverpod/core/api.dart';
import 'package:pokemon_riverpod/core/api_routes.dart';
import 'package:pokemon_riverpod/core/locator.dart';
import 'package:pokemon_riverpod/core/paginated_data.dart';
import 'package:pokemon_riverpod/features/pokemon/domain/pokemon_list_item.dart';

class PokemonListNotifier
    extends AsyncNotifier<PaginatedData<List<PokemonListItem>>> {
  final _api = locator.get<Api>();

  @override
  FutureOr<PaginatedData<List<PokemonListItem>>> build() async {
    return getPokemons();
  }

  Future<PaginatedData<List<PokemonListItem>>> getPokemons() async {
    final response = await _api.get(ApiRoutes.getPokemons());
    List<PokemonListItem> pokemons =
        ((response.data?['results'] ?? []) as List<dynamic>)
            .map((e) => PokemonListItem.fromJson(e))
            .toList();
    PaginatedData<List<PokemonListItem>> paginatedPokemons =
        PaginatedData.fromApiResponse(
      response.data,
      pokemons,
    );

    inspect(state);

    return paginatedPokemons;
  }
}

final pokemonListProvider = AsyncNotifierProvider<PokemonListNotifier, PaginatedData<List<PokemonListItem>>>(() {
  return PokemonListNotifier();
});
