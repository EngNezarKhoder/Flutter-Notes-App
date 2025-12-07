import 'package:flutter/material.dart';

class MyIndicator extends StatelessWidget {
  const MyIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: const Color.fromARGB(255, 41, 120, 185),
      ),
    );
  }
}
