import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FillterScreen extends StatefulWidget {
  static const routeName = '/fillters';
  final Function saveFilters;
  final Map<String, bool> currentFillters;
  FillterScreen(this.saveFilters, this.currentFillters);

  @override
  State<FillterScreen> createState() => _FillterScreenState();
}

class _FillterScreenState extends State<FillterScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _loctoseFree = false;
  @override
  initState() {
    _glutenFree = widget.currentFillters['gluten'];
    _loctoseFree = widget.currentFillters['lactose'];
    _vegan = widget.currentFillters['vegan'];
    _vegetarian = widget.currentFillters['vegitarian'];

    super.initState();
  }

  Widget _buildSwitchListtile(
      String title, String subtitle, bool currentbool, Function updatedvalue) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: currentbool,
      onChanged: updatedvalue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('fillters'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                final selectedFillters = {
                  'gluten': _glutenFree,
                  'lactose': _loctoseFree,
                  'vegan': _vegan,
                  'vegitarian': _vegetarian,
                };
                widget.saveFilters(selectedFillters);
              },
            ),
          ],
        ),
        drawer: MainDrawer(),
        body: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                'adjust your meal',
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            Expanded(
                child: ListView(
              children: <Widget>[
                _buildSwitchListtile(
                  'glutonfree',
                  'only include glutenfree meals',
                  _glutenFree,
                  (newvalue) {
                    setState(() {
                      _glutenFree = newvalue;
                    });
                  },
                ),
                _buildSwitchListtile(
                  'vegetarianfree',
                  'only include vegfree meals',
                  _vegetarian,
                  (newvalue) {
                    setState(() {
                      _vegetarian = newvalue;
                    });
                  },
                ),
                _buildSwitchListtile(
                  'veganfree',
                  'only include veganfree meals',
                  _vegan,
                  (newvalue) {
                    setState(() {
                      _vegan = newvalue;
                    });
                  },
                ),
                _buildSwitchListtile(
                  'loctosefree',
                  'only include loctosefree meals',
                  _loctoseFree,
                  (newvalue) {
                    setState(() {
                      _loctoseFree = newvalue;
                    });
                  },
                ),
              ],
            ))
          ],
        ));
  }
}
