import 'package:fitness_app/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as math;

class RadialProgressBar extends StatefulWidget {
  @override
  _RadialProgressBarState createState() => _RadialProgressBarState();
}

class _RadialProgressBarState extends State<RadialProgressBar>
    with TickerProviderStateMixin {
  var animationController;
  var animation;
  var progressDegrees = 0.0;
  var count=0;

  void _initialAnimations(){
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    animation = Tween(begin: 0.0, end: 255.0).animate((CurvedAnimation(
        parent: animationController,curve: Curves.elasticInOut
    )))
      ..addListener(() {
        setState(() {
          progressDegrees = animation.value;
          print(progressDegrees);
        });
      });

    animationController.forward();
  }

  @override
  void initState() {
    super.initState();
    _initialAnimations();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: RadialPainter(progressComplete: progressDegrees),
      child: Container(
        height: 220,
        width: 220,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "RUNNING",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 24,
                  letterSpacing: 1.5),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              width: 120,
              height: 7,
              decoration: BoxDecoration(
                  color: darkBackground,
                  borderRadius: BorderRadius.circular(24)),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "1.225",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 42,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5,
            ),
            InkWell(
              onTap: (){
                _initialAnimations();
              },
              child: Text(
                "CALORIES BURN",
                style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RadialPainter extends CustomPainter {
  var progressComplete;

  RadialPainter({this.progressComplete});

  @override
  void paint(Canvas canvas, Size size) {
    var width = size.width;
    var height = size.height;

    var completeCircle = Paint()
      ..color = Colors.black12
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;

    var center = Offset(width / 2, height / 2);
    canvas.drawCircle(center, width / 2, completeCircle);

    var progressPaint = Paint()
      ..shader = LinearGradient(
              colors: [Colors.purple, Colors.purpleAccent, Colors.pinkAccent])
          .createShader(Rect.fromCircle(center: center, radius: width / 2))
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
        Rect.fromCircle(center: center, radius: width / 2),
        math.radians(-90),
        math.radians(progressComplete),
        false,
        progressPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
