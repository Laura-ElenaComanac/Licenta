import 'package:flutter/material.dart';
import 'package:projyproject/ui_screens/helpers/svg/svg.dart';

/* Vector Ellipse 9
    Autogenerated by FlutLab FTF Generator
  */
class GeneratedEllipse9Widget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 261.0,
      height: 69.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10000),
            topRight: Radius.circular(10000),
            bottomLeft: Radius.circular(100000),
            bottomRight: Radius.circular(100000)),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(63, 0, 0, 0),
            offset: Offset(0.0, 10.0),
            blurRadius: 20.0,
          )
        ],
      ),
      child: SvgWidget(painters: [
        SvgPathPainter.fill()
          ..addPath(
              'M261 34.5C261 53.5538 202.573 69 130.5 69C58.4268 69 0 53.5538 0 34.5C0 15.4462 58.4268 0 130.5 0C202.573 0 261 15.4462 261 34.5Z')
          ..color = Color.fromARGB(255, 102, 59, 223),
      ]),
    );
  }
}
