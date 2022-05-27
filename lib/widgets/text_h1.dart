import 'package:flutter/material.dart';

class TextH1 extends StatelessWidget {
  final String title;
  final Color? color;

  TextH1({required this.title, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(title,
        style: TextStyle(
            fontSize: 36,
            color: color ?? Colors.white,
            fontWeight: FontWeight.bold));
  }
}

class TextH2 extends StatelessWidget {
  final String title;
  final Color? color;

  TextH2({required this.title, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(title,
        style: TextStyle(
            fontSize: 28,
            color: color ?? Colors.white,
            fontWeight: FontWeight.bold));
  }
}

class TextH3 extends StatelessWidget {
  final String title;
  final Color? color;

  TextH3({required this.title, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(title,
        style: TextStyle(
            fontSize: 22,
            color: color ?? Colors.white,
            fontWeight: FontWeight.bold));
  }
}

class TextH4 extends StatelessWidget {
  final String title;
  final Color? color;

  TextH4({required this.title, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(title,
        style: TextStyle(
            fontSize: 18,
            color: color ?? Colors.white,
            fontWeight: FontWeight.bold));
  }
}
