import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../model/bid_draw_model.dart';
import '../utils/constants.dart';

// class CircleLinePainter extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;

//     final double targetX = 0.3 * screenWidth; // 30% of the screen width
//     final double targetY = 0.5 * screenHeight; // 50% of the screen height
//     return Scaffold(
//       body: Column(
//         children: [
//           Container(
//             width: 300.h,
//             height: 300.h,
//             child: CustomPaint(
//               painter:
//                   CircleLinePainterCustom(targetX: targetX, targetY: targetY),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CircleLinePainterCustom extends CustomPainter {
//   final double targetX;
//   final double targetY;
//   CircleLinePainterCustom({required this.targetX, required this.targetY});

//   // final double targetX = 0.3 * screenWidth; // 30% of the screen width
//   // final double targetY = 0.5 * screenHeight; // 50% of the screen height
//   final double circleWidth = 20;
//   final double circleHeight = 20;
//   final int circleCount = 50;
//   final double spacing = 50; // Vertical spacing between circles
//   var bidDrawList = [
//     BidDrawModel(id: 0, x: 130.w, y: 130.h, isRegular: false),
//     BidDrawModel(id: 1, x: 120.w, y: 155.h),
//     BidDrawModel(id: 2, x: 110.w, y: 180.h),
//     BidDrawModel(id: 3, x: 100.w, y: 205.h),
//     BidDrawModel(id: 4, x: 90.w, y: 230.h),
//     BidDrawModel(id: 5, x: 80.w, y: 255.h),
//     BidDrawModel(id: 6, x: 70.w, y: 280.h),
//     BidDrawModel(id: 7, x: 60.w, y: 305.h),
//     BidDrawModel(id: 8, x: 50.w, y: 330.h),
//     BidDrawModel(id: 9, x: 40.w, y: 355.h),
//     BidDrawModel(id: 10, x: 30.w, y: 380.h),
//     BidDrawModel(id: 11, x: 20.w, y: 405.h, isRegular: false),
//   ];
//   @override
//   void paint(Canvas canvas, Size size) {
//     var items = bidDrawList;
//     for (var item in items) {
//       final Paint circlePaint = Paint()
//         ..color = item.isRegular ? Colors.blue.shade700 : Colors.orange;
//       canvas.drawOval(
//         Rect.fromCenter(
//           center: Offset(item.x, item.y + circleHeight.h),
//           width: circleWidth.w,
//           height: circleHeight.h,
//         ),
//         circlePaint,
//       );
//     }
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return false;
//   }
// }

class CircularRosaryChaplet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const double circleRadius = 180.0; // Increased radius
    const int decadesCount = 5;
    const int beadsPerDecade =
        11; // 10 blue + 1 red at the beginning + 1 red at the end
    const double angleIncrement = 2 * pi / (decadesCount * beadsPerDecade);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Container(
          width: 2 * circleRadius,
          height: 2 * circleRadius,
          child: CustomPaint(
            painter: CircularRosaryPainter(
              circleRadius: circleRadius,
              decadesCount: decadesCount,
              beadsPerDecade: beadsPerDecade,
              angleIncrement: angleIncrement,
            ),
          ),
        ),
      ),
    );
  }
}

class CircularRosaryPainter extends CustomPainter {
  final double circleRadius;
  final int decadesCount;
  final int beadsPerDecade;
  final double angleIncrement;

  CircularRosaryPainter({
    required this.circleRadius,
    required this.decadesCount,
    required this.beadsPerDecade,
    required this.angleIncrement,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;

    final Paint beadPaint = Paint()
      ..color = const Color.fromARGB(109, 33, 149, 243);
    final Paint startEndBeadPaint = Paint()..color = Colors.orange;
    final Paint countedBeadPaint = Paint()
      ..color = Color.fromARGB(242, 23, 79, 125);

    double startAngle = pi / 2; // Starting angle at the bottom left

    for (int decadeIndex = 0; decadeIndex < decadesCount; decadeIndex++) {
      double angle = startAngle + angleIncrement * decadeIndex * beadsPerDecade;

      for (int beadIndex = 0; beadIndex < beadsPerDecade; beadIndex++) {
        double x = centerX + circleRadius * cos(angle);
        double y = centerY + circleRadius * sin(angle);

        if (decadeIndex < 2 && beadIndex != 0) {
          if (decadeIndex == 1 && beadIndex < 5) {
            canvas.drawCircle(Offset(x, y), 7, countedBeadPaint);
          } else {
            canvas.drawCircle(Offset(x, y), 7, beadPaint);
          }
        } else {
          if (beadIndex == 0) {
            canvas.drawCircle(Offset(x, y), 7, startEndBeadPaint);
          } else {
            canvas.drawCircle(Offset(x, y), 5, beadPaint);
          }
        }

        angle += angleIncrement; // Increment the angle clockwise
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
