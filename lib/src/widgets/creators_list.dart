import 'package:flutter/material.dart';
import 'package:marvel_app/src/provider/series_provider.dart';

class CreatorsListView extends StatefulWidget {
  CreatorsListView({this.id});
  int id;
  @override
  _CreatorsListViewState createState() => _CreatorsListViewState();
}

class _CreatorsListViewState extends State<CreatorsListView> {
  SeriesProvider creatorsProvider = new SeriesProvider();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: creatorsProvider.getCreator(widget.id),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            return snapshot.data.length == 0 || snapshot.data ==[] ? _noCreators() : CustomScrollView(
              slivers: [
                SliverList(
                    delegate: SliverChildBuilderDelegate((context, i) {
                      return _creatorTile(snapshot.data[i].fullName.toString(),snapshot.data[i].thumbnail.path.toString(),snapshot.data[i].thumbnail.extension.toString());
                    }, childCount: snapshot.data.length),)
              ],
            );
          } else {
            return Container(
              height: 400,
              child: Center(child: CircularProgressIndicator()),
            );
          }
        });
  }

  _noCreators () {
    return Center(child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Text('Esta serie no posee creadores cagardos en la base de datos.', style: TextStyle(fontSize: 24.0),),
    ),);
  }

  _creatorTile(nombre,image,extension) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: ListTile(
        leading: CircleAvatar(
        backgroundImage: NetworkImage(image + "/portrait_uncanny." + extension),
          radius: 30.0,
        ),
        title: Text(nombre) ,
      ),
    );
  }
}
