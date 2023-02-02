import 'package:flutter/material.dart';
import '../widgets/category_item.dart';
import '../dummy_data.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView(
        padding: const EdgeInsets.all(25),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 /2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20
        ),
        children: dummyCategories.map((catData) => CategoryItem(catData.color, catData.title, catData.id)).toList(),
      ),
    );
  }
}
