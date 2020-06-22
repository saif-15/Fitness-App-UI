import 'package:fitness_app/bloc/date_time_bloc.dart';
import 'package:fitness_app/colors.dart';
import 'package:flutter/material.dart';

import 'formatter.dart';

class TopBar extends StatefulWidget {
  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {

  var dateTimeBloc;
  @override
  void initState() {
    dateTimeBloc=Bloc();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    print("build");
    return Stack(
      children: <Widget>[
        CustomPaint(
          painter: TopBarPainter(),
          child: Container(
            height: 250,
          ),
        ),
        Positioned(
          top: 40,
          left: 0,
          right: 0,
          child:Row(
              children: <Widget>[
                IconButton(icon: Icon(Icons.arrow_back_ios),color: Colors.white,onPressed: (){
                 dateTimeBloc.subtractDate();
                },),
                StreamBuilder(
                  stream: dateTimeBloc.dateTime,
                  initialData: dateTimeBloc.currentDate,
                   builder: (context,snapshot){
                    return Expanded(
                    child: Column(
                      children: <Widget>[
                        Text(dayFormat.format(snapshot.data),style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                          color: Colors.white,
                        ),),
                        Text(dateFormat.format(snapshot.data),style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),),
                      ],
                    ),
                  );
                   }
                ),
                Transform.rotate(angle: 3.1,child:
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: (){
                      dateTimeBloc.addDate();
                    },
                    color: Colors.white,
                  ),)
              ],
            ),
          )
      ],
    );
  }

  @override
  void dispose() {
    dateTimeBloc.dispose();
    super.dispose();
  }


}

class TopBarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var width = size.width;
    var height = size.height;
    var firstLayer = Paint()..color = firstBackground;
    var firstPath = Path()
      ..lineTo(0, height * 0.8)
      ..quadraticBezierTo(width / 8, height / 2, width / 4, height * 0.8)
      ..quadraticBezierTo(width * 0.375, height, width / 2, height * 0.8)
      ..quadraticBezierTo(width * 0.625, height / 2, width * 0.75, height * 0.8)
      ..quadraticBezierTo(width * 0.875, height, width, height * 0.8)
      ..lineTo(width, 0)
      ..close();

    canvas.drawPath(firstPath, firstLayer);

    var thirdlayer = Paint()..color = darkBackground;
    var lastPath = Path()
      ..lineTo(0, height * 0.8)
      ..quadraticBezierTo(width * 0.1, height / 2, width * 0.35, height * 0.8)
      ..quadraticBezierTo(width * 0.5, height, width * 0.6, height * 0.8)
      ..quadraticBezierTo(width * 0.8, height * 0.3, width, height * 0.9)
      ..lineTo(width, 0)
      ..close();

    canvas.drawPath(lastPath, thirdlayer);

    var secondlayer = Paint()..color = secondBackground;
    var secondPath = Path()
      ..lineTo(0, height * 0.65)
      ..quadraticBezierTo(width / 4, 50, width *0.6, height * 0.7)
      ..quadraticBezierTo(width * 0.8, height, width, height * 0.35)
      ..lineTo(width, 0)
      ..close();
    canvas.drawPath(secondPath, secondlayer);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
