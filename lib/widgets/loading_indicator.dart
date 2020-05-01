import 'package:flutter/material.dart';

/// Centered [CircularProgressIndicator]
class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: const CircularProgressIndicator(),
    );
  }
}