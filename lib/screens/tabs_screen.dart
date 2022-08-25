import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/meal.dart';
import 'package:flutter_complete_guide/widgets/main_drawer.dart';
import '../screens/categories_screen.dart';
import './favourites_screen.dart';

class TapsScreen extends StatefulWidget {
  final List<Meal> favouriteMeal;
  TapsScreen(this.favouriteMeal);
  @override
  State<TapsScreen> createState() => _TapsScreenState();
}

class _TapsScreenState extends State<TapsScreen> {
  List<Map<String, Object>> _pages;

  int _SelectPageIndex = 0;
  @override
  void initState() {
    _pages = [
      {
        'pages': CategoriesScreen(),
        'title': 'categories',
      },
      {
        'pages': FavouritesScreen(widget.favouriteMeal),
        'title': 'favourites',
      }
    ];
    super.initState();
  }

  void _SelectPages(int index) {
    setState(() {
      _SelectPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_SelectPageIndex]['title']),
      ),
      drawer: Drawer(
        child: MainDrawer(),
      ),
      body: _pages[_SelectPageIndex]['pages'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _SelectPages,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        currentIndex: _SelectPageIndex,
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.category),
            title: Text('categories'),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.star),
            title: Text('Favourites'),
          ),
        ],
      ),
    );
  }
}
