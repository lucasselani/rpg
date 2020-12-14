import 'package:flutter/material.dart';

class BusyScreen extends StatelessWidget {
  final Color backgroundColor;
  final Color progressColor;

  BusyScreen({this.backgroundColor, this.progressColor});

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Container(
          color: backgroundColor ?? Colors.white,
          child: Center(
            child: progressColor != null
                ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                  )
                : CircularProgressIndicator(),
          ),
        ),
      );
}
