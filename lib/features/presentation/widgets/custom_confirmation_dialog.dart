import 'package:flutter/material.dart';

class CustomConfirmationDialog extends StatelessWidget {
  final String title;
  final String content;

  final VoidCallback onTap;
  const CustomConfirmationDialog(
      {super.key,
      required this.title,
      required this.onTap,
      required this.content});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Vazgeç'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            onTap();
          },
          child: const Text('Evet'),
        ),
      ],
    );
  }
}
