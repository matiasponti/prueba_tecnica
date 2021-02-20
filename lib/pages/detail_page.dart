import 'package:flutter/material.dart';
import 'package:marvel_app/widgets/creators_list.dart';

class DetailPage extends StatefulWidget {
  DetailPage({this.id});
  int id;
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Creadores'),
        leading: _back(),
      ),
      body: CreatorsListView(id: widget.id,)
    );
  }

  _back() {
    return GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Icon(Icons.arrow_back_ios));
  }
}