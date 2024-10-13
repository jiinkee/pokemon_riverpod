import 'package:flutter/material.dart';
import 'package:pokemon_riverpod/core/app_database.dart';
import 'package:pokemon_riverpod/core/locator.dart';
import 'package:pokemon_riverpod/features/pokemon/presentation/pokemon_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void clearCache() {
    final db = locator.get<AppDatabase>();
    db.pokemonDao.deletePokemons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokemon'),
      ),
      body: const PokemonListWidget(),
      floatingActionButton: FloatingActionButton(onPressed: clearCache),
    );
  }
}
