import 'package:fitness_app/radial_progressbar.dart';
import 'package:fitness_app/top_bar.dart';
import 'package:flutter/material.dart';

void main()=>runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body:Column(
            children: <Widget>[
              TopBar(),
              RadialProgressBar()
            ],
          ),
        ),
    );
  }
}
