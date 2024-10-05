// ignore_for_file: public_member_api_docs, sort_constructors_first
class PokemonListItem {
  final String name;
  final String url;

  PokemonListItem({
    required this.name,
    required this.url,
  });

  factory PokemonListItem.fromJson(Map<String, dynamic> source) {
    return PokemonListItem(
      name: source['name']?.toString() ?? '',
      url: source['url']?.toString() ?? '',
    );
  }
}
