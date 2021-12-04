import 'package:flutter/material.dart';
import 'package:loveria/utils/helpers/constants.dart';

class CircularLoading extends StatefulWidget {
  final Color color;

  const CircularLoading({Key? key, required this.color}) : super(key: key);
  @override
  State<CircularLoading> createState() => _CircularLoadingState();
}

class _CircularLoadingState extends State<CircularLoading> {
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(
        widget.color,
      ),
    );
  }
}
