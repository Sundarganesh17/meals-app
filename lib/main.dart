import 'package:flutter/material.dart';
import './dummy_data.dart';
import '../models/meal.dart';
import '../screens/fillier_screen.dart';
import '../screens/categiries_meals_detail.dart';
import '../screens/categories-meals-screen.dart';
import '../screens/tabs_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _fillters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegitarian': false,
  };
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favouritesMeals = [];

  void _setFillters(Map<String, bool> filltersData) {
    setState(() {
      _fillters = filltersData;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_fillters['gluten'] && !meal.isGlutenFree) {
          return false;
        }
        if (_fillters['lactose'] && !meal.isLactoseFree) {
          return false;
        }
        if (_fillters['vegan'] && !meal.isVegan) {
          return false;
        }
        if (_fillters['vegitarian'] && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavourite(String mealId) {
    final existingIndex =
        _favouritesMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        _favouritesMeals.removeAt(existingIndex);
      });
    } else {
      setState(
        () {
          _favouritesMeals.add(
            DUMMY_MEALS.firstWhere((meal) => meal.id == mealId),
          );
        },
      );
    }
  }

  bool _isMealFavourite(String id) {
    return _favouritesMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'DeliMeals',
        theme: ThemeData(
            primarySwatch: Colors.pink,
            accentColor: Colors.amber,
            canvasColor: Color.fromRGBO(255, 254, 229, 1),
            fontFamily: 'Raleway',
            textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1: TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                bodyText2: TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                headline1: TextStyle(
                    fontSize: 18,
                    fontFamily: 'RobotoCondensed',
                    fontWeight: FontWeight.bold))),
        // home: CategoriesScreen(),
        initialRoute: '/',
        routes: {
          '/': (ctx) => TapsScreen(_favouritesMeals),
          CategoriesMeals.routeName: (ctx) => CategoriesMeals(
                _availableMeals,
              ),
          MealDetailScreen.routeName: (ctx) =>
              MealDetailScreen(_toggleFavourite, _isMealFavourite),
          FillterScreen.routeName: (ctx) =>
              FillterScreen(_setFillters, _fillters)
        });
  }
}
