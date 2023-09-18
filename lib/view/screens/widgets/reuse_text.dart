import 'package:flutter/material.dart';

class ReUseTxtWedget extends StatelessWidget {
  final String title;

  const ReUseTxtWedget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      // ignore: avoid_unnecessary_containers
      child: Container(
        child: Text(
          title,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, letterSpacing: 4),
        ),
      ),
    );
  }
}
