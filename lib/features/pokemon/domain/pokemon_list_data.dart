// ignore_for_file: public_member_api_docs, sort_constructors_first
class PokemonListData {
  final String name;
  final String url;

  PokemonListData({
    required this.name,
    required this.url,
  });

  factory PokemonListData.fromJson(Map<String, dynamic> source) {
    return PokemonListData(
      name: source['name']?.toString() ?? '',
      url: source['url']?.toString() ?? '',
    );
  }
}
