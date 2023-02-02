import 'package:flutter/material.dart';
import '../dummy_data.dart';
import '../widgets/meal_item.dart';
import '../models/meal.dart';

class CategoryMeals extends StatelessWidget {
  static const routeName = '/category-meals';
  // final String categoryId;
  // final String categoryTitle;
  final List<Meal>  availableMeals;
 const CategoryMeals(this.availableMeals, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final categoryTitle = routeArgs['title'];
    final categoryId = routeArgs['id'];
    final categoryMeals = availableMeals.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();

    return Scaffold(
        appBar: AppBar(
          title: Text(categoryTitle as String),
        ),
        body: ListView.builder(
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
        ));
  }
}
