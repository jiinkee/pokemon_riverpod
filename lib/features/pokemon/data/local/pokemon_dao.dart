import 'package:floor/floor.dart';
import 'package:pokemon_riverpod/features/pokemon/data/local/pokemon_local.dart';

@dao
abstract class PokemonDao {
  @insert
  Future<void> insertPokemon(PokemonLocal pokemon);

  @Query('SELECT * FROM pokemons WHERE id = :id')
  Future<PokemonLocal?> findPokemonById(int id);

  @Query('SELECT * FROM pokemons WHERE name = :name')
  Future<PokemonLocal?> findPokemonByName(String name);

  @Query('DELETE FROM pokemons')
  Future<void> deletePokemons();
}