import 'dart:async';

import 'package:flutter/material.dart';
import 'package:marvel_app/models/series_model.dart';
import 'package:marvel_app/pages/detail_page.dart';
import 'package:marvel_app/provider/series_provider.dart';

class SeriesGrid extends StatefulWidget {
  @override
  _SeriesGridState createState() => _SeriesGridState();
}

class _SeriesGridState extends State<SeriesGrid> {
  SeriesProvider seriesProvider = new SeriesProvider();
  int offset = 0;
  Future<List<Serie>> series;

  @override
  void initState() {
    series = seriesProvider.getSeries(offset);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: series,
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            return RefreshIndicator(
              onRefresh: _onRefresh,
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 5.0,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                  SliverGrid(
                      delegate: SliverChildBuilderDelegate((context, i) {
                        return _serieWidget(
                            snapshot.data[i].thumbnail.path.toString(),
                            snapshot.data[i].thumbnail.extension.toString(),
                            snapshot.data[i].title.toString(),
                            snapshot.data[i].id);
                      }, childCount: snapshot.data.length),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 5.0,
                          crossAxisSpacing: 5.0)),
                  SliverToBoxAdapter(
                      child: SizedBox(
                    height: 5.0,
                    width: MediaQuery.of(context).size.width,
                  ))
                ],
              ),
            );
          } else {
            return Container(
              height: 400,
              child: Center(child: CircularProgressIndicator()),
            );
          }
        });
  }

  _serieWidget(image, extension, titulo, id) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DetailPage(id: id)),
      ),
      child: Stack(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: FadeInImage(
              image: NetworkImage(image + "/portrait_uncanny." + extension),
              placeholder: AssetImage('assets/no-image.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white,
              gradient: LinearGradient(
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  colors: [
                    Colors.grey.withOpacity(0.0),
                    Colors.black,
                  ])),
        ),
        Positioned(
            bottom: 15.0,
            left: 15.0,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.45,
              child: Text(
                titulo,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                ),
              ),
            ))
      ]),
    );
  }

  Future<Null> _onRefresh() {
    final duration = new Duration(seconds: 1);

    new Timer(duration, () {
      setState(() {
        offset = offset + 20;
        series = seriesProvider.getSeries(offset);
      });
    });

    return Future.delayed(duration);
  }
}
