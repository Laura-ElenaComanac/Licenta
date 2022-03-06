import 'package:flutter/material.dart';
import 'package:projyproject/ui_screens/helpers/svg/svg.dart';
import 'package:projyproject/ui_screens/helpers/transform/transform.dart';

/* Vector Line 10
    Autogenerated by FlutLab FTF Generator
  */
class GeneratedLine10Widget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TransformHelper.rotate(
        a: 1.00,
        b: -0.01,
        c: 0.01,
        d: 1.00,
        child: Container(
          width: 283.00750732421875,
          height: 0.0,
          child: SvgWidget(painters: [
            SvgPathPainter.stroke(
              1.0,
              strokeJoin: StrokeJoin.miter,
            )
              ..addPath(
                  'M-6.55822e-06 0.5L283.008 0.5L283.008 -0.5L-6.55822e-06 -0.5L-6.55822e-06 0.5Z')
              ..color = Color.fromARGB(255, 102, 59, 223),
          ]),
        ));
  }
}
