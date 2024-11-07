import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PokemonListItemSkeleton extends StatelessWidget {
  const PokemonListItemSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Skeletonizer(
      enabled: true,
      child: ListTile(
        leading: SizedBox(
          height: 50,
          width: 50,
          child: CircleAvatar(),
        ),
        title: Text('Loading......'),
        subtitle: Text('Loading.....'),
      ),
    );
  }
}
