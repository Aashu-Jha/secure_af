import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

var kTextFormFieldInputDecoration = InputDecoration(
  labelText: 'Title',
  labelStyle: TextStyle(fontSize: 18.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.0),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
    borderRadius: BorderRadius.circular(8.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
    borderRadius: BorderRadius.circular(8.0),
  )
);


void launchURL(String url, BuildContext context) async => await canLaunch(url)
    ? await launch(url)
    : ScaffoldMessenger.of(context)
    .showSnackBar(SnackBar(content: Text('Could not launch $url'))
);

