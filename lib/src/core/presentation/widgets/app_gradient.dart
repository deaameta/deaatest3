import 'package:flutter/material.dart';

class AppGradient extends StatefulWidget {
  final double dx;
  final double dy;
  final List<Color> colors;
  final List<double> stops;
  const AppGradient({required this.dx, required this.dy, required this.stops, required this.colors, Key? key}) : super(key: key);

  @override
  State<AppGradient> createState() => _AppGradientState();
}

class _AppGradientState extends State<AppGradient> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          radius: 1,
          center: Alignment(widget.dx, widget.dy),
          stops: widget.stops,
          colors: widget.colors,
        ),
      ),
    );
  }
}
