import 'package:flutter/material.dart';


class DrawPage extends StatefulWidget {
  @override
  DrawPageState createState() => DrawPageState();
}

class DrawPageState extends State<DrawPage> with SingleTickerProviderStateMixin  {

  Animation<double> _animation;
  AnimationController controller;

  double waveGap = 10.0;
  double waveRadius = 0.0;
  double y = 0.0;

  CurvedAnimation _curvedAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: Duration(milliseconds: 1500), vsync: this);

    controller.forward();

    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reset();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context)
  {
    _animation = Tween(begin: 0.0, end: waveGap).animate(controller)
      ..addListener(() {
        setState(() {
          waveRadius = _animation.value;
        });
      });


    _curvedAnimation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    _curvedAnimation.addListener(() {
      setState(() {
        y = _curvedAnimation.value;
      });
    });

    return  Scaffold(

        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: CustomPaint(
            painter: ShapesPainter(waveRadius,y),
            child: Container(
              height: 700,
            ),
          ),
        ),

    );
  }
}

class ShapesPainter extends CustomPainter {
  final double waveRadius;
  final double y;
  ShapesPainter(this.waveRadius, this.y);
  @override
  void paint(Canvas canvas, Size size, )
  {
    final paint = Paint();

    // set the paint color to be white
    paint.color = Colors.white;

    // Create a rectangle with size and width same as the canvas
    var rect = Rect.fromLTWH(0, 0, size.width, size.height);

    // draw the rectangle using the paint
    canvas.drawRect(rect, paint);

    paint.color = Colors.yellow;

    // create a path
    var path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width, 0);
    // close the path to form a bounded shape
    path.close();

    canvas.drawPath(path, paint);

    // set the color property of the paint
    paint.color = Colors.deepOrange;

    // center of the canvas is (x,y) => (width/2, height/2)
    var center = Offset(size.width / 2, size.height / 2+y*100);

    // draw the circle with center having radius 75.0
    canvas.drawCircle(center, waveRadius, paint);
  }

  @override
  bool shouldRepaint(ShapesPainter oldDelegate) {
    return oldDelegate.waveRadius != waveRadius;
  }



}
