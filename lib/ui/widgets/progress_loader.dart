import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomProgressIndicator {
  buildShowDialog(BuildContext context, {bool isRectangleRequired = false}) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: Container(
              height: 70,
              width: 70,
              color: isRectangleRequired ? Colors.white : Colors.transparent,
              // decoration: BoxDecoration(
              //     //borderRadius: BorderRadius.circular(5.r),
              //     color: Colors.white.withOpacity(0.8),
              //     shape: BoxShape.circle),
              child: Center(
                child: Lottie.asset('assets/lottie/round loader.json'),
              ),
            ),
          );
        });
  }
}
