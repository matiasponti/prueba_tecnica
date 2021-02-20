import 'package:flutter/material.dart';
import 'package:marvel_app/src/utils/app_localization.dart';

class SupportPage extends StatefulWidget {
  @override
  _SupportPageState createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(AppLocalizations.of(context).translate('support')),
        leading: _back(),
      ),
      body: Center(
        child: Text(AppLocalizations.of(context).translate('support'), style: TextStyle(fontSize: 22.0),),
      ),
    );
  }

  _back() {
    return GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Icon(Icons.arrow_back_ios));
  }
}
