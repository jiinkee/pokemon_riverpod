// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:floor/floor.dart';
import 'package:pokemon_riverpod/features/pokemon/domain/pokemon.dart';

// have to create a new class for cached data because Floor does not accept num & Object type
@Entity(tableName: 'pokemons')
class PokemonLocal {
  @primaryKey
  final int id;
  final String name;
  final int baseExperience;
  final int height;
  final bool isDefault;
  final int order;
  final int weight;
  final String sprite;

  PokemonLocal({
    required this.id,
    required this.name,
    required this.baseExperience,
    required this.height,
    required this.isDefault,
    required this.order,
    required this.weight,
    required this.sprite,
  });

  factory PokemonLocal.fromPokemon(Pokemon pokemon) {
    return PokemonLocal(
      id: pokemon.id,
      name: pokemon.name,
      baseExperience: pokemon.baseExperience.toInt(),
      height: pokemon.height.toInt(),
      isDefault: pokemon.isDefault,
      order: pokemon.order.toInt(),
      weight: pokemon.weight.toInt(),
      sprite: pokemon.sprite.toJson(),
    );
  }
}
