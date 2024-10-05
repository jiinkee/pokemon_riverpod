import 'package:get_it/get_it.dart';
import 'package:pokemon_riverpod/core/api.dart';

GetIt locator = GetIt.instance;

void setUpLocator() {
  locator.registerLazySingleton(() => Api());
}