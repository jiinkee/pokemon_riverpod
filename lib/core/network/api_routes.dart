class ApiRoutes {
  static String domain() {
    return 'https://pokeapi.co/api/v2';
  }

  static String getPokemons() {
    return '/pokemon';
  }

  static String getPokemon(String id) {
    return '/pokemon/$id';
  }
}