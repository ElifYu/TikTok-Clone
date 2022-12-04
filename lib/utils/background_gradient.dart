import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  Background({Key? key, this.child}) : super(key: key);
  var child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [

            Color(0xFF070C0C),
            Color(0xFF070C0C),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: child,
    );
  }
}