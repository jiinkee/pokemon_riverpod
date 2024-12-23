import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_riverpod/core/extensions/debounce_cancel_api.dart';
import 'package:pokemon_riverpod/core/network/api_routes.dart';
import 'package:pokemon_riverpod/core/pagination_data.dart';
import 'package:pokemon_riverpod/features/pokemon/domain/pokemon_list_data.dart';

class PokemonListNotifier
    extends AsyncNotifier<PaginationData<List<PokemonListData>>> {

  @override
  FutureOr<PaginationData<List<PokemonListData>>> build() async {
    return getPokemons();
  }

  Future<PaginationData<List<PokemonListData>>> getPokemons() async {
    Response? response;

    // API debouncing
    final api = await ref.getDebouncedApi();

    // load the first page
    if (state.value == null) {
      response = await api.get(endpoint: ApiRoutes.getPokemons());
    } else {
      response = await api.get(completeUrl: state.value?.next ?? '');
    }

    if (response != null && response.data != null) {
      List<PokemonListData> pokemons =
          ((response.data?['results'] ?? []) as List<dynamic>)
              .map((e) => PokemonListData.fromJson(e))
              .toList();

      List<PokemonListData>? previous = state.value?.results;
      PaginationData<List<PokemonListData>> current =
          PaginationData.fromApiResponse(
        response.data,
        pokemons,
      );

      PaginationData<List<PokemonListData>> newState = current.copyWith(
        results: [
          ...?previous,
          ...?current.results,
        ],
      );
      // IMPORTANT: need to reassign the state value so that consumer can be notified
      state = AsyncData(newState);
      // just returning the state value will not notify consumer
      return newState;
    }

    return PaginationData();
  }
}

// AsyncNotifierProvider will provide AsyncValue
final pokemonListProvider = AsyncNotifierProvider<PokemonListNotifier,
    PaginationData<List<PokemonListData>>>(() {
  return PokemonListNotifier();
});
