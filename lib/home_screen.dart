import 'package:flutter/material.dart';
import 'package:pokemon_riverpod/features/pokemon/presentation/pokemon_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokemon'),
      ),
      body: const PokemonListWidget(),
    );
  }
}
