// ignore_for_file: public_member_api_docs, sort_constructors_first
class Sprite {
  final String backDefalt;
  final String backFemale;
  final String backShiny;
  final String backShinyFemale;
  final String frontDefault;
  final String frontFemale;
  final String frontShiny;
  final String frontShinyFemale;

  Sprite({
    required this.backDefalt,
    required this.backFemale,
    required this.backShiny,
    required this.backShinyFemale,
    required this.frontDefault,
    required this.frontFemale,
    required this.frontShiny,
    required this.frontShinyFemale,
  });

  factory Sprite.fromJson(Map<String, dynamic> source) {
    return Sprite(
      backDefalt: source['back_default']?.toString() ?? '',
      backFemale: source['back_female']?.toString() ?? '',
      backShiny: source['back_shiny']?.toString() ?? '',
      backShinyFemale: source['back_shiny_female']?.toString() ?? '',
      frontDefault: source['front_default']?.toString() ?? '',
      frontFemale: source['front_female']?.toString() ?? '',
      frontShiny: source['front_shiny']?.toString() ?? '',
      frontShinyFemale: source['front_shiny_female']?.toString() ?? '',
    );
  }
}
