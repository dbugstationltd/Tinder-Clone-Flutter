import 'package:flutter/material.dart';

Padding dot() {
  return Padding(
    padding: const EdgeInsets.all(4),
    child: Container(
      height: 6.52,
      width: 6.52,
      decoration: const BoxDecoration(
        color: Color(0xFFABABAC),
        shape: BoxShape.circle,
      ),
    ),
  );
}
