import 'dart:developer';

import 'package:flutter/material.dart';

class KJButton extends StatelessWidget {
  const KJButton({
    required this.onPressed,
    required this.child,
    super.key,
  });
  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.orange.shade300,
              offset: const Offset(0, 10),
              blurStyle: BlurStyle.solid,
            ),
          ],
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            padding: const EdgeInsets.all(4),
            minimumSize: Size.zero,
            backgroundColor: Colors.orange.shade200,
          ),
          onPressed: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Builder(
              builder: (context) {
                final too = DefaultTextStyle.of(context);
                final type = context.findAncestorWidgetOfExactType<Widget>();
                log('too $too');
                return child;
              },
            ),
          ),
        ),
      ),
    );
  }
}
