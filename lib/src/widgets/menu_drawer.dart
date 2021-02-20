import 'package:flutter/material.dart';
import 'package:marvel_app/src/utils/app_localization.dart';


class MenuDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Drawer(
      elevation: 15.0,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Container(),
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/marvel-menu.jpg'))),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text(AppLocalizations.of(context).translate('settings')),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, 'settings');
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text(AppLocalizations.of(context).translate('support')),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, 'support');
            },
          ),
        ],
      ),
    );
  }
}
