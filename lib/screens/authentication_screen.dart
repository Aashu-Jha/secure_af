import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:secure_af/models/master_password_provider.dart';
import 'package:secure_af/screens/home_screen.dart';

class Authentication extends StatefulWidget{
  static const id = 'authentication_screen';

  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  String _password;
  bool _isTrue = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    getMasterPassword();
    super.didChangeDependencies();
  }

  void getMasterPassword() async {
    _password = await Provider.of<MasterPassword>(context).getMasterPassword();
  }

  @override
  Widget build(BuildContext context) {
    return buildScaffold(context);
  }

  Scaffold buildScaffold(BuildContext context) {
    return Scaffold(
    backgroundColor: Theme.of(context).primaryColor,
    body: Container(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image(
            image: AssetImage(
            'assets/images/logo.png',
            ),
          ),
          TextField(
            textAlign: TextAlign.center,
            obscureText: true,
            autofocus: true,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 30.0),
              hintText: 'Type password here..',
              hintStyle: TextStyle(
                fontSize: 15.0,
              ),
              enabled: true,
              enabledBorder: OutlineInputBorder(
                borderSide:
                BorderSide(color: _isTrue ? Colors.lightBlueAccent : Colors.red, width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                BorderSide(color: _isTrue ? Colors.lightBlueAccent : Colors.red, width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
              ),

              filled: true,
              fillColor: Theme.of(context).bottomAppBarColor,
            ),
            onChanged: (String value) {
              if(value == _password) {
                Navigator.pushReplacementNamed(context, HomeScreen.id);
              }
            },
            onSubmitted: (value) {
              if(value != _password) {
                setState(() {
                  _isTrue = false;
                });
              }else{
                Navigator.pushReplacementNamed(context, HomeScreen.id);
              }

            },
          ),
        ],
      ),
    ),
  );
  }
}
