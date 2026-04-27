class Ingredient {
  final String name;
  final String measure;

  Ingredient({required this.name, required this.measure});

  factory Ingredient.fromJson(Map<String, dynamic> json, int index) {
    return Ingredient(
      name: json['strIngredient$index'] as String? ?? '',
      measure: json['strMeasure$index'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'measure': measure,
    };
  }

  Ingredient copyWith({
    String? name,
    String? measure,
  }) {
    return Ingredient(
      name: name ?? this.name,
      measure: measure ?? this.measure,
    );
  }
}
