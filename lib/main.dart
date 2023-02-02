import 'package:flutter/material.dart';
import 'package:meals/dummy_data.dart';
import './screens/categories_screen.dart';
import './screens/category_meals.dart';
import '../screens/more_detail_screen.dart';
import '../screens/tabs_screen.dart';
import '../screens/filter_screen.dart';
import '../models/meal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false
  };

  List<Meal> availableMeals = dummyMeals;
  List<Meal> favoriteMeals = [];

  void setFilters(Map<String, bool> filterData) {
    setState(() {
      filters = filterData;

      availableMeals = dummyMeals.where((meal) {
        if (filters['gluten']! && !meal.isGlutenFree) {
          return false;
        }

        if (filters['lactose']! && !meal.isLactoseFree) {
          return false;
        }

        if (filters['vegan']! && !meal.isVegan) {
          return false;
        }

        if (filters['vegetarian']! && !meal.isVegetarian) {
          return false;
        }

        return true;
      }).toList();
    });
  }
  
  void toggleFavorite(String mealId) {
    final existingIndex = favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if(existingIndex >= 0) {
      setState(() {
        favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        favoriteMeals.add(dummyMeals.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool isMealFavorite(String id) {
    return favoriteMeals.any((meal) => meal.id == id);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meals App',
      theme: ThemeData(
          canvasColor: const Color.fromRGBO(255, 254, 229, 1),
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink)
              .copyWith(secondary: Colors.amber),
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1: const TextStyle(
                    color: Color.fromRGBO(20, 51, 51, 1),
                    fontFamily: 'RobotoCondensed'),
                bodyText2:
                    const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              )),
      // home: const CategoriesScreen(),
      initialRoute: '/',
      routes: {
        '/': (context) => TabsScreen(favoriteMeals),
        CategoryMeals.routeName: (context) => CategoryMeals(availableMeals),
        MoreDetailScreen.routeName: (context) => MoreDetailScreen(toggleFavorite, isMealFavorite),
        FilterScreen.routeName: (context) => FilterScreen(filters, setFilters)
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => const CategoriesScreen());
      },
    );
  }
}
