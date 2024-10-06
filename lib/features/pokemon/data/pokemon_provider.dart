import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_riverpod/core/api.dart';
import 'package:pokemon_riverpod/core/locator.dart';
import 'package:pokemon_riverpod/features/pokemon/domain/pokemon.dart';

final pokemonProvider =
    FutureProvider.autoDispose.family<Pokemon?, String>((ref, url) async {
  final api = locator.get<Api>();

  final response = await api.get(completeUrl: url);

  if (response != null && response.data != null) {
    final pokemon = Pokemon.fromJson(response.data);
    return pokemon;
  }
  return null;
});
