import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:secure_af/constants.dart';
import 'package:secure_af/models/pass_card_list.dart';

class PassCardDetails extends StatelessWidget {
  static const id = 'pass_card_details';

  @override
  Widget build(BuildContext context) {
    final cardID = ModalRoute.of(context).settings.arguments as String;
    final _data = Provider.of<PassCardList>(context).findByID(cardID);

    void showCopyAlert() {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Copied!'), duration: Duration(seconds: 2),)
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_outlined),
        ),
        title: Text(_data.title),
      ),
      body: Container(
        child: SafeArea(
          child: Container(
            child: Form(
              child: Consumer<PassCardList>(
                builder: (ctx, _card, _) =>
                ListView(
                  padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 25),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: TextFormField(
                        decoration: kTextFormFieldInputDecoration.copyWith(labelText: 'accountID').copyWith(
                          suffixIcon: IconButton(icon: Icon(Icons.copy), onPressed: () {
                            Clipboard.setData(ClipboardData(text: _data.accountID));
                            showCopyAlert();
                          }),
                        ),
                        readOnly: true,
                        initialValue: _data.accountID,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: TextFormField(
                        decoration: kTextFormFieldInputDecoration.copyWith(labelText: 'username').copyWith(
                          suffixIcon: IconButton(icon: Icon(Icons.copy), onPressed: () {
                            Clipboard.setData(ClipboardData(text: _data.username));
                            showCopyAlert();
                          }),
                        ),
                        readOnly: true,
                        initialValue: _data.username,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: TextFormField(
                        decoration: kTextFormFieldInputDecoration.copyWith(labelText: 'password').copyWith(
                          suffixIcon: IconButton(icon: Icon(Icons.copy), onPressed: () {
                            Clipboard.setData(ClipboardData(text: _data.password));
                            showCopyAlert();
                          }),
                        ),
                        readOnly: true,
                        initialValue: _data.password,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: TextFormField(
                        decoration: kTextFormFieldInputDecoration.copyWith(labelText: 'website'),
                        readOnly: true,
                        initialValue: _data.website,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: TextFormField(
                        maxLines: 3,
                        decoration: kTextFormFieldInputDecoration.copyWith(labelText: 'notes'),
                        readOnly: true,
                        initialValue: _data.notes,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: TextFormField(
                        decoration: kTextFormFieldInputDecoration.copyWith(labelText: 'other'),
                        readOnly: true,
                        initialValue: _data.other,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

}
