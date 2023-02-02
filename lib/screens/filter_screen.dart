import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = '/filters';

  Function setFilters;
  final Map<String, bool> currentFilters;

  FilterScreen(this.currentFilters, this.setFilters, {Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool glutenFree = false;
  bool vegetarianFree = false;
  bool vegan = false;
  bool lactoseFree = false;

  @override
  void initState() {
    // TODO: implement initState
    glutenFree = widget.currentFilters['gluten']!;
    vegetarianFree = widget.currentFilters['vegetarian']!;
    vegan = widget.currentFilters['vegan']!;
    lactoseFree = widget.currentFilters['lactose']!;
    super.initState();
  }

  Widget buildSwitchListTile(String title, String subTitle, bool currentValue,
      dynamic updateValue) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(subTitle),
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
        actions: [
          IconButton(onPressed: () {
            final selectedFilters = {
              'gluten': glutenFree,
              'lactose': lactoseFree,
              'vegan': vegan,
              'vegetarian': vegetarianFree
            };

            widget.setFilters(selectedFilters);
          }, icon: const Icon(Icons.save))
        ],
      ),
      drawer: const MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                buildSwitchListTile(
                  'Gluten Free',
                  'Only include gluten free',
                  glutenFree,
                  (newValue) {
                    setState(() {
                      glutenFree = newValue;
                    });
                  },
                ),
                buildSwitchListTile(
                  'Vegetarian Free',
                  'Only include vegetarian free',
                  vegetarianFree,
                      (newValue) {
                    setState(() {
                      vegetarianFree = newValue;
                    });
                  },
                ),
                buildSwitchListTile(
                  'Lactose Free',
                  'Only include lactose free',
                  lactoseFree,
                      (newValue) {
                    setState(() {
                      lactoseFree = newValue;
                    });
                  },
                ),
                buildSwitchListTile(
                  'Vegan',
                  'Only include vegan',
                  vegan,
                      (newValue) {
                    setState(() {
                      vegan = newValue;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
