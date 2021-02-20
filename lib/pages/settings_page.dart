import 'package:flutter/material.dart';
import 'package:marvel_app/utils/app_localization.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(AppLocalizations.of(context).translate('settings')),
        leading: _back(),
      ),
      body: Center(
        child: Text(AppLocalizations.of(context).translate('settings'), style: TextStyle(fontSize: 22.0),),
      ),
    );
  }

  _back() {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
        child: Icon(Icons.arrow_back_ios));
  }
}
