import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final double size;
  const Logo({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        color: Colors.black,
        height: size * 1.8,
        width: size * 7.2,
        child: Text(
          'N-Limbo',
          style: TextStyle(
            color: Colors.white,
            fontSize: size,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
