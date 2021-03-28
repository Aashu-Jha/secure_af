import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:secure_af/models/dartk_theme_provider.dart';
import 'package:secure_af/screens/about_screen.dart';
import 'package:secure_af/constants.dart' as cons;

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  bool switchVal = false;

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);

    return Drawer(
      child: ListView(
        children: <Widget>[
          Container(
            // height: MediaQuery.of(context).size.height / 3 + 30,
            child: Column(
              children: <Widget>[
                AppBar(
                  leading: IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                  ),
                  title: Text('Secure_AF'),
                ),
                Image(
                  // color: Colors.black,
                  height: 200,
                  width: 300,
                  image: AssetImage('assets/images/logo.png'),
                  fit: BoxFit.cover,
                )
              ],
            ),
            color: Theme.of(context).primaryColor,
          ),
          Container(
            child: Column(
              children: <ListTile>[
                ListTile(
                    leading: Icon(FontAwesomeIcons.lowVision),
                    title: Text('Theme Switch'),
                    trailing: Switch(
                      value: themeChange.darkTheme,
                      onChanged: (bool value) {
                        setState(() {
                          themeChange.darkTheme = value;
                        });
                      },
                    )),
                ListTile(
                  onTap: () {
                    Scaffold.of(context).openEndDrawer();
                    Navigator.pushNamed(context, AboutScreen.id);
                  },
                  leading: Icon(Icons.account_box_outlined),
                  title: Text('About'),
                ),
                ListTile(
                  onTap: () {
                    cons.launchURL('https://github.com/aashu-jha', context);
                  },
                  leading: Icon(Icons.star_rate_outlined),
                  title: Text('Rate App'),
                ),
                ListTile(
                  onTap: () {
                    cons.launchURL(
                        'https://github.com/aashu-jha/secure_af', context);
                  },
                  leading: Icon(FontAwesomeIcons.github),
                  title: Text('Contribute'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
