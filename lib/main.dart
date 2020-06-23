import 'package:fitness_app/radial_progressbar.dart';
import 'package:fitness_app/top_bar.dart';
import 'package:flutter/material.dart';

import 'list.dart';

void main() => runApp(MaterialApp(
      home: MyApp(),
      debugShowCheckedModeBanner: false,
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  var animationController;

  @override
  void initState() {
    animationController = AnimationController(vsync: this,duration: Duration(seconds: 1));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      TopBar(),
                      RadialProgressBar(),
                      SizedBox(
                        height: 20.0,
                      ),
                      ListData(),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Positioned(
              left: width / 2 - 25,
              bottom: 30.0,
              child: Center(
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.red, width: 4.0)),
                  child: IconButton(
                      icon: AnimatedIcon(
                        icon: AnimatedIcons.menu_close,
                        progress: animationController.view,
                      ),
                      onPressed: () {
                        onIconPressed();
                      }),
                ),
              ))
        ],
      ),
    );
  }

  void onIconPressed() {
    animationStatus
        ? animationController.reverse()
        : animationController.forward();
  }

  bool get animationStatus {
    return animationController.status == AnimationStatus.completed;
  }
}
