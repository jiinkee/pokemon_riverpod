import 'package:flutter/material.dart';

class PokemonListItem extends StatelessWidget {
  final String url;

  const PokemonListItem({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Text(url);
  }
}