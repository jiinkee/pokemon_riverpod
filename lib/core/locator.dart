import 'package:get_it/get_it.dart';
import 'package:pokemon_riverpod/core/app_database.dart';
import 'package:pokemon_riverpod/core/network/api.dart';

GetIt locator = GetIt.instance;

void setUpLocator() async {
  locator.registerLazySingleton(() => Api());
  locator.registerSingletonAsync<AppDatabase>(() async {
    return $FloorAppDatabase.databaseBuilder('app_database.db').build();
  });

  await locator.allReady();
}