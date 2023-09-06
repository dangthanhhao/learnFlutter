import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';

class FavoriteMealsNotifer extends StateNotifier<List<Meal>> {
  FavoriteMealsNotifer() : super([]);
  bool toggleMealFavoritesMeal(Meal meal) {
    final mealIsFavorite = state.contains(meal);
    if (mealIsFavorite) {
      state = state.where((element) => element.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }

  bool isFavorited(Meal meal) => state.contains(meal);
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifer, List<Meal>>(
        (ref) => FavoriteMealsNotifer());
