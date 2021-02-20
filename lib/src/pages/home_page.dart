import 'package:flutter/material.dart';
import 'package:marvel_app/src/provider/series_provider.dart';
import 'package:marvel_app/src/widgets/menu_drawer.dart';
import 'package:marvel_app/src/widgets/series_grid.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SeriesProvider seriesProvider = new SeriesProvider();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Marvel App'),
      ),
      drawer: MenuDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: SeriesGrid(),
      ),
    );
  }

}
