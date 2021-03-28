import 'package:flutter/material.dart';
import 'package:secure_af/constants.dart';
import 'package:secure_af/models/master_password_provider.dart';
import 'package:secure_af/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  String _password;
  final _welcomeForm = GlobalKey<FormState>();
  FocusNode _node = FocusNode();
  TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _onSaved() async {
    if(!_welcomeForm.currentState.validate())
      return;
    _welcomeForm.currentState.save();
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString(MasterPassword.PASSWORD, _password);
    Navigator.of(context).pushReplacementNamed(HomeScreen.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Secure_AF'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(30),
          child: Form(
            key: _welcomeForm,
            child: Column(
              children: <Widget>[
                Text('Welcome', style: Theme.of(context).textTheme.headline5, textAlign: TextAlign.start,),
                Divider(thickness: 2,),
                Text('NOTE: Please register a master password to start using the application. Note that if the master password is lost, the stored date can\'t be recovered because of the missing sync option. There\'s no backup option in the app for now.',
                  style: Theme.of(context).textTheme.subtitle1,
                  softWrap: true,
                ),
                SizedBox(height: 20,),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  autofocus: true,
                  obscureText: true,
                  controller: _controller,
                  decoration: kTextFormFieldInputDecoration.copyWith(labelText: 'Password'),
                  onSaved: (value) {
                    _password = value;
                  },
                  validator: (value) {
                    return _validateField1(value);
                  },
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(_node);
                    return _validateField1(value);
                  },
                ),
                SizedBox(height: 10,),
                TextFormField(
                  textInputAction: TextInputAction.done,
                  focusNode: _node,
                  decoration: kTextFormFieldInputDecoration.copyWith(labelText: 'Password'),
                  validator: (value) {
                    if(_controller.text.toString() != value) {
                      return 'Enter same password';
                    }
                    return null;
                  },
                ),
                SizedBox(height:20),
                ElevatedButton(onPressed: _onSaved, child: Text(
                  'REGISTER',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                  style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context).buttonColor
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _validateField1(String value) {
    if(value.length < 7)
      return 'Enter more than six characters';
    return null;
  }
}
