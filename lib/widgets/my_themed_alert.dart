import 'package:flutter/material.dart';

class MyThemedAlert extends StatelessWidget {
  const MyThemedAlert({
    super.key,
    required this.actions,
    required this.title,
    required this.content,
  });
  final Text title;
  final Text content;

  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor.withRed(100),
      title: title,
      content: Wrap(
        children: [content],
      ),
      actions: actions,
    );
  }
}
