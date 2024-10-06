import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_riverpod/core/api.dart';
import 'package:pokemon_riverpod/core/api_routes.dart';
import 'package:pokemon_riverpod/core/locator.dart';
import 'package:pokemon_riverpod/core/pagination_data.dart';
import 'package:pokemon_riverpod/features/pokemon/domain/pokemon_list_data.dart';

class PokemonListNotifier
    extends AsyncNotifier<PaginationData<List<PokemonListData>>> {
  final _api = locator.get<Api>();

  @override
  FutureOr<PaginationData<List<PokemonListData>>> build() async {
    return getPokemons();
  }

  Future<PaginationData<List<PokemonListData>>> getPokemons() async {
    final response = await _api.get(endpoint: ApiRoutes.getPokemons());

    if (response != null && response.data != null) {
      List<PokemonListData> pokemons =
          ((response.data?['results'] ?? []) as List<dynamic>)
              .map((e) => PokemonListData.fromJson(e))
              .toList();
      PaginationData<List<PokemonListData>> paginatedPokemons =
          PaginationData.fromApiResponse(
        response.data,
        pokemons,
      );
      return paginatedPokemons;
    }

    return PaginationData();
  }
}

// AsyncNotifierProvider will provide AsyncValue
final pokemonListProvider = AsyncNotifierProvider<PokemonListNotifier,
    PaginationData<List<PokemonListData>>>(() {
  return PokemonListNotifier();
});
