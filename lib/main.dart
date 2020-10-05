import 'package:breakingbad/screens/karakterListesiEkran.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Breaking Bad App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Color(0xFF67e6dc),
        accentColor: Color(0xFFeb4d4b),
        secondaryHeaderColor: Color(0xFF222f3e),
        backgroundColor: Color(0xFFfc5c65),
      ),
      home: Karakterler(),
    );
  }
}
