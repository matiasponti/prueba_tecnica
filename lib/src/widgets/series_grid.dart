import 'dart:async';
import 'package:flutter/material.dart';
import 'package:marvel_app/src/models/series_model.dart';
import 'package:marvel_app/src/pages/detail_page.dart';
import 'package:marvel_app/src/provider/series_provider.dart';

class SeriesGrid extends StatefulWidget {
  @override
  _SeriesGridState createState() => _SeriesGridState();
}

class _SeriesGridState extends State<SeriesGrid> {
  SeriesProvider seriesProvider = new SeriesProvider();
  ScrollController _scrollController = new ScrollController();
  int offset = 0;
  Future<List<Serie>> series;
  int _ultimaSerie = 20;
  bool isLoading = false;

  @override
  void initState() {
    series = seriesProvider.getSeries(offset, _ultimaSerie);
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          isLoading = true;
        });
        _fetchMore();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: series,
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            return RefreshIndicator(
              onRefresh: _onRefresh,
              child: Stack(
                children: [ CustomScrollView(
                  controller: _scrollController,
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
                            childAspectRatio: 0.75,
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
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: _loader(),
                  )
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
              width: MediaQuery.of(context).size.width * 0.40,
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
    final duration = new Duration(seconds: 2);

    new Timer(duration, () {
      setState(() {
        offset = offset + 20;
        series = seriesProvider.getSeries(offset, _ultimaSerie);
      });
    });

    return Future.delayed(duration);
  }

  Future<Null> _fetchMore() {
    final duration = new Duration(seconds: 2);

    new Timer(duration, () {
      setState(() {
        _ultimaSerie = _ultimaSerie + 6;
        series = seriesProvider.getSeries(offset, _ultimaSerie);
        isLoading = false;
      });
    });

    return Future.delayed(duration);
  }

  Widget _loader () {
    if(isLoading) {
      return CircularProgressIndicator();
    } else {
      return Container();
    }
  }

}



