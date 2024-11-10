import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_riverpod/core/app_database.dart';
import 'package:pokemon_riverpod/core/locator.dart';
import 'package:pokemon_riverpod/features/pokemon/presentation/favourite/favourite_pokemon_list.dart';
import 'package:pokemon_riverpod/features/pokemon/presentation/listing/pokemon_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void clearCache(BuildContext context) {
    final db = locator.get<AppDatabase>();
    db.pokemonDao.deletePokemons().then((_) {
      // this method - the snackback always shows behind the opened drawer
      // BuildContext ctx = NavigationHelper.rootNavigator.currentContext!;
      // ScaffoldMessenger.of(ctx).showSnackBar(
      //   const SnackBar(
      //     elevation: 10,
      //     content: Text('Cache cleared successfully.'),
      //   ),
      // );

      // solution: need to use overlay to simulate the "snackbar" behaviour above the visible drawer
      final OverlayEntry overlayEntry = OverlayEntry(builder: (ctx) {
        return Positioned(
          bottom: 0, // means 0 space from the bottom of screen
          left: 0,
          right: 0, // means the snackbar will span across whole screen width
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.8),
              ),
              child: Center(
                child: Text(
                  'Cache cleared successfully.',
                  style: Theme.of(ctx)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        );
      });

      if (context.mounted) {
        Overlay.of(context).insert(
          overlayEntry,
        );

        Future.delayed(const Duration(seconds: 3), () {
          overlayEntry.remove();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokemon'),
      ),
      body: const Column(
        children: [
          FavouritePokemonList(),
          Expanded(child: PokemonListWidget()),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const SizedBox(
              height: 50,
              child: DrawerHeader(
                margin: EdgeInsets.zero,
                child: Text('Settings'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
              child: InkWell(
                onTap: () => clearCache(context),
                child: const Row(
                  children: [
                    Icon(
                      CupertinoIcons.trash,
                      size: 14,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text('Clear Cache'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
