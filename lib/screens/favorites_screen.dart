import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> categoryMeals;
  const FavoritesScreen(this.categoryMeals, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    if(categoryMeals.isEmpty) {
      return const Center(
        child: Text('You have no favorites'),
      );
    } else {
      return ListView.builder(
        itemBuilder: (ctx, i) {
          return  MealItem(
              id: categoryMeals[i].id,
              title: categoryMeals[i].title,
              imageUrl: categoryMeals[i].imageUrl,
              duration: categoryMeals[i].duration,
              complexity:  categoryMeals[i].complexity,
              affordability: categoryMeals[i].affordability
          );
        },
        itemCount: categoryMeals.length,
      );
    }

  }
}
