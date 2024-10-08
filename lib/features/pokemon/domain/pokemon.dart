// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:pokemon_riverpod/features/pokemon/domain/sprite.dart';

class Pokemon {
  final String id;
  final String name;
  final num baseExperience;
  final num height;
  final bool isDefault;
  final num order;
  final num weight;
  final Sprite sprite;

  Pokemon({
    required this.id,
    required this.name,
    required this.baseExperience,
    required this.height,
    required this.isDefault,
    required this.order,
    required this.weight,
    required this.sprite,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      baseExperience:
          num.tryParse(json['base_experience']?.toString() ?? '') ?? 0,
      height: num.tryParse(json['height']?.toString() ?? '') ?? 0,
      isDefault: json['is_default'] ?? false,
      order: num.tryParse(json['order']?.toString() ?? '') ?? 0,
      weight: num.tryParse(json['weight']?.toString() ?? '') ?? 0,
      sprite: Sprite.fromJson(json['sprites']),
    );
  }
}
