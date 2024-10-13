import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:pokemon_riverpod/features/pokemon/data/local/pokemon_dao.dart';
import 'package:pokemon_riverpod/features/pokemon/data/local/pokemon_local.dart';

part 'app_database.g.dart';

@Database(version: 1, entities: [PokemonLocal])
abstract class AppDatabase extends FloorDatabase {
  PokemonDao get pokemonDao;
}