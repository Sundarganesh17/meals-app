import 'package:flutter/material.dart';

import '../widgets/meal_items.dart';
import '../models/meal.dart';
import '../dummy_data.dart';

class CategoriesMeals extends StatefulWidget {
  static const String routeName = '/categoryMeal';
  final List<Meal> availableMeals;
  CategoriesMeals(this.availableMeals);

  @override
  State<CategoriesMeals> createState() => _CategoriesMealsState();
}

class _CategoriesMealsState extends State<CategoriesMeals> {
  String categoryTitle;
  List<Meal> displayedMeals;
  var _loadedIniData = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_loadedIniData) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      categoryTitle = routeArgs['title'];
      final Categoriesid = routeArgs['id'];
      displayedMeals = widget.availableMeals.where((meal) {
        return meal.categories.contains(Categoriesid);
      }).toList();
      _loadedIniData = true;
    }
    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
    setState(() {
      displayedMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  //final String Categoriesid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(categoryTitle),
        ),
        body: ListView.builder(
          itemBuilder: (ctx, index) {
            return MealItem(
              id: displayedMeals[index].id,
              title: displayedMeals[index].title,
              Imgurl: displayedMeals[index].imageUrl,
              Duration: displayedMeals[index].duration,
              complexity: displayedMeals[index].complexity,
              affordability: displayedMeals[index].affordability,
            );
          },
          itemCount: displayedMeals.length,
        ));
  }
}
