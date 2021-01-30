import 'package:flutter/material.dart';

class CustomLogo extends StatelessWidget {
  final String imagePath;
  final double size;

  const CustomLogo(this.imagePath, this.size);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40.0),
      child: Center(
        child: Image.asset(
          imagePath,
          width: size,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
