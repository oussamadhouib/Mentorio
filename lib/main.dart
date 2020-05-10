import 'package:flutter/material.dart';
import 'package:mentorio/pages/root_page.dart';
import 'package:mentorio/services/authentication.dart';
import 'package:flutter/services.dart';
void main() {

  return runApp(MyApp());

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Mentorio',
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
          primarySwatch: Colors.yellow,
        ),
        home: new RootPage(auth: new Auth()));
  }
}