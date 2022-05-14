import 'package:flutter/material.dart';

class CenterError extends StatelessWidget {
  final Object message;

  const CenterError(this.message, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Error:\n$message', style: const TextStyle(color: Color(0xff970f0f), fontFamily: 'monospace')),
          ],
        ),
      ),
    );
  }
}
