import 'package:flutter/cupertino.dart';

class PassCard {
  final String id;
  final String title;
  final String accountID;
  final String username;
  final String password;
  final String website;
  final String notes;
  final String other;

  PassCard({@required this.id, @required this.title, this.accountID, this.username, @required this.password, this.website, this.notes,
      this.other});

}