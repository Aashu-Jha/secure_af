import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:secure_af/models/pass_card.dart';
import 'package:secure_af/models/pass_card_list.dart';
import 'package:flutter/services.dart';

import '../constants.dart';

class AddPassword extends StatefulWidget {
  static const id = 'add_password';

  @override
  _AddPasswordState createState() => _AddPasswordState();
}

class _AddPasswordState extends State<AddPassword> {
  bool _isShown = false;
  bool _isLoading = false;
  final _form = GlobalKey<FormState>();
  final _accountIDNode = FocusNode();
  final _usernameNode = FocusNode();
  final _passwordNode = FocusNode();
  final _websiteNode = FocusNode();
  final _notesNode = FocusNode();
  var _editedCard = PassCard(id: null, title: '', password: '', accountID: '', username: '', website: '', notes: '', other: '');

  var _initValue = {
    'title' : '',
    'accountID' : '',
    'username' : '',
    'password' : '',
    'website' : '',
    'notes' : '',
    'other' : '',

  };

  Future<void> _saveForm() async {
    final bool isValid = _form.currentState.validate();
    if(!isValid) {
      return;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      Provider.of<PassCardList>(context, listen: false).addCard(_editedCard);
    } catch (e) {
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Process Failed!'),
          content: Text('Something went wrong'),
          actions: [
            TextButton(onPressed: () {
              Navigator.of(ctx).pop();
            }, child: Text('Okay'))
          ],
        ),
      );
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _accountIDNode.dispose();
    _usernameNode.dispose();
    _passwordNode.dispose();
    _websiteNode.dispose();
    _notesNode.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.close),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: _saveForm,
            child: Text(
              'SAVE ',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },

        child: _isLoading ? Center(child: CircularProgressIndicator()) : Form(
          key: _form,
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 25),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: TextFormField(
                    initialValue: _initValue['title'],
                    decoration: kTextFormFieldInputDecoration.copyWith(labelText: 'Title'),
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_accountIDNode);
                    },
                    onSaved: (value) {
                      _editedCard = PassCard(
                          id: _editedCard.id,
                          title: value,
                          accountID: _editedCard.accountID,
                          username: _editedCard.username,
                          password: _editedCard.password,
                          website: _editedCard.website,
                          notes: _editedCard.notes,
                          other: _editedCard.other,
                      );
                    },
                    validator: (value) {
                      if(value.trim().isEmpty) {
                        return 'Required Field';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: TextFormField(
                    initialValue: _initValue['accountID'],
                    decoration: kTextFormFieldInputDecoration.copyWith(labelText: 'accountID'),
                    textInputAction: TextInputAction.next,
                    focusNode: _accountIDNode,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_usernameNode);
                    },
                    onSaved: (value) {
                      _editedCard = PassCard(
                        id: _editedCard.id,
                        title: _editedCard.title,
                        accountID: value,
                        username: _editedCard.username,
                        password: _editedCard.password,
                        website: _editedCard.website,
                        notes: _editedCard.notes,
                        other: _editedCard.other,
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: TextFormField(
                    initialValue: _initValue['username'],
                    decoration: kTextFormFieldInputDecoration.copyWith(labelText: 'username'),
                    textInputAction: TextInputAction.next,
                    focusNode: _usernameNode,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_passwordNode);
                    },
                    onSaved: (value) {
                      _editedCard = PassCard(
                        id: _editedCard.id,
                        title: _editedCard.title,
                        accountID: _editedCard.accountID,
                        username: value,
                        password: _editedCard.password,
                        website: _editedCard.website,
                        notes: _editedCard.notes,
                        other: _editedCard.other,
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          initialValue: _initValue['password'],
                          decoration: kTextFormFieldInputDecoration.copyWith(
                              labelText: 'password',
                          ),
                          obscureText: _isShown == true ? false: true,
                          textInputAction: TextInputAction.next,
                          focusNode: _passwordNode,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(_websiteNode);
                          },
                          onSaved: (value) {
                            _editedCard = PassCard(
                              id: _editedCard.id,
                              title: _editedCard.title,
                              accountID: _editedCard.accountID,
                              username: _editedCard.username,
                              password: value,
                              website: _editedCard.website,
                              notes: _editedCard.notes,
                              other: _editedCard.other,
                            );
                          },
                          validator: (value) {
                            if(value.isEmpty || value.length < 1) {
                              return 'Required Field';
                            }
                            if(value.contains(' '))
                              return 'Can\'t use "space"';
                            return null;
                          },
                        ),
                      ),
                      IconButton(icon: Icon(Icons.remove_red_eye), onPressed: () {
                        setState(() {
                          _isShown = !_isShown;
                        });
                      }),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: TextFormField(
                    initialValue: _initValue['website'],
                    decoration: kTextFormFieldInputDecoration.copyWith(labelText: 'website'),
                    textInputAction: TextInputAction.next,
                    focusNode: _websiteNode,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_notesNode);
                    },
                    onSaved: (value) {
                      _editedCard = PassCard(
                        id: _editedCard.id,
                        title: _editedCard.title,
                        accountID: _editedCard.accountID,
                        username: _editedCard.username,
                        password: _editedCard.password,
                        website: value,
                        notes: _editedCard.notes,
                        other: _editedCard.other,
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: TextFormField(
                    initialValue: _initValue['notes'],
                    decoration: kTextFormFieldInputDecoration.copyWith(labelText: 'notes'),
                    focusNode: _notesNode,
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                    onSaved: (value) {
                      _editedCard = PassCard(
                        id: _editedCard.id,
                        title: _editedCard.title,
                        accountID: _editedCard.accountID,
                        username: _editedCard.username,
                        password: _editedCard.password,
                        website: _editedCard.website,
                        notes: value,
                        other: _editedCard.other,
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: TextFormField(
                    decoration: kTextFormFieldInputDecoration.copyWith(labelText: 'other'),
                    textInputAction: TextInputAction.done,
                    onSaved: (value) {
                      _editedCard = PassCard(
                        id: _editedCard.id,
                        title: _editedCard.title,
                        accountID: _editedCard.accountID,
                        username: _editedCard.username,
                        password: _editedCard.password,
                        website: _editedCard.website,
                        notes: _editedCard.notes,
                        other: value,
                      );
                    },
                    onFieldSubmitted: (_) {
                      _saveForm();
                    },
                  ),
                ),
              ],
            ),
        ),
      ),
    );
  }
}

