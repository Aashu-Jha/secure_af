import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:secure_af/models/master_password_provider.dart';
import 'package:secure_af/models/pass_card_list.dart';
import 'package:secure_af/models/styles.dart';
import 'package:secure_af/screens/about_screen.dart';
import 'package:secure_af/screens/add_password.dart';
import 'package:secure_af/screens/authentication_screen.dart';
import 'package:secure_af/screens/home_screen.dart';
import 'package:secure_af/screens/pass_card_details.dart';
import 'package:secure_af/screens/welcome_page.dart';

import 'models/dartk_theme_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _password;
  DarkThemeProvider themeChangeProvider = new DarkThemeProvider();
  MasterPassword masterPassword = MasterPassword();

  @override
  void initState() {
    getCurrentAppTheme();
    getMasterPassword();
    super.initState();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
    await themeChangeProvider.darkThemePreference.getTheme();
  }

  void getMasterPassword() async {
    _password = await masterPassword.getMasterPassword();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: themeChangeProvider,
        ),
        ChangeNotifierProvider.value(
          value: masterPassword,
        ),
        ChangeNotifierProvider.value(
            value: PassCardList(),
        ),
      ],
      child: Consumer<DarkThemeProvider>(
        builder: (ctx, darkTheme, child) => MaterialApp(
          title: 'Password Manager',
          theme: Styles.themeData(darkTheme.darkTheme, context),
          home: _password == '' ? WelcomePage() : Authentication(),
          debugShowCheckedModeBanner: false,
          routes: {
            Authentication.id : (context) => Authentication(),
            HomeScreen.id : (context) => HomeScreen(),
            AddPassword.id: (context) => AddPassword(),
            PassCardDetails.id: (context) => PassCardDetails(),
            AboutScreen.id: (context) => AboutScreen(),
          },
        ),
      ),
    );
  }
}
