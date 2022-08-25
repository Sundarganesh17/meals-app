import 'package:flutter/material.dart';
import '../screens/categories-meals-screen.dart';
import 'dart:ui';

class CatItem extends StatelessWidget {
  final String title;
  final Color color;
  final String id;
  CatItem(this.title, this.color, this.id);

  void SelectCategory(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(CategoriesMeals.routeName,
        arguments: {'id': id, 'title': title});
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => SelectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: EdgeInsets.all(15),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline1,
          textAlign: TextAlign.center,
        ),
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color.withOpacity(0.7), color],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}
