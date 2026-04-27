import 'ingredient.dart';
class Meal {
  final String idMeal;
  final String strMeal;
  final String strMealThumb;
  final String? strCategory;
  final String? strArea;
  final String? strInstructions;
  final String? strYoutube;
  final List<Ingredient> ingredients;

  Meal({
    required this.idMeal,
    required this.strMeal,
    required this.strMealThumb,
    this.strCategory,
    this.strArea,
    this.strInstructions,
    this.strYoutube,
    required this.ingredients,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    final List<Ingredient> ingredients = [];
    for (int i = 1; i <= 20; i++) {
      final ingredientName = json['strIngredient$i'] as String?;
      final measure = json['strMeasure$i'] as String?;
      if (ingredientName != null && ingredientName.trim().isNotEmpty) {
        ingredients.add(Ingredient(
          name: ingredientName,
          measure: measure ?? '',
        ));
      }
    }

    return Meal(
      idMeal: json['idMeal'] as String,
      strMeal: json['strMeal'] as String,
      strMealThumb: json['strMealThumb'] as String,
      strCategory: json['strCategory'] as String?,
      strArea: json['strArea'] as String?,
      strInstructions: json['strInstructions'] as String?,
      strYoutube: json['strYoutube'] as String?,
      ingredients: ingredients,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'idMeal': idMeal,
      'strMeal': strMeal,
      'strMealThumb': strMealThumb,
      'strCategory': strCategory,
      'strArea': strArea,
      'strInstructions': strInstructions,
      'strYoutube': strYoutube,
    };

    for (int i = 0; i < ingredients.length; i++) {
      data['strIngredient${i + 1}'] = ingredients[i].name;
      data['strMeasure${i + 1}'] = ingredients[i].measure;
    }

    return data;
  }

  Meal copyWith({
    String? idMeal,
    String? strMeal,
    String? strMealThumb,
    String? strCategory,
    String? strArea,
    String? strInstructions,
    String? strYoutube,
    List<Ingredient>? ingredients,
  }) {
    return Meal(
      idMeal: idMeal ?? this.idMeal,
      strMeal: strMeal ?? this.strMeal,
      strMealThumb: strMealThumb ?? this.strMealThumb,
      strCategory: strCategory ?? this.strCategory,
      strArea: strArea ?? this.strArea,
      strInstructions: strInstructions ?? this.strInstructions,
      strYoutube: strYoutube ?? this.strYoutube,
      ingredients: ingredients ?? this.ingredients,
    );
  }
}
