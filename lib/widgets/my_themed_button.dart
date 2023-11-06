import 'package:flutter/material.dart';

class MyThemedButton extends StatelessWidget {
  const MyThemedButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.height,
  });

  final void Function() onPressed;
  final Widget child;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(
                Theme.of(context).scaffoldBackgroundColor.withRed(100),
              ),
              foregroundColor: MaterialStatePropertyAll(
                Theme.of(context).highlightColor,
              ),
              minimumSize: MaterialStateProperty.resolveWith(
                (states) {
                  return Size.fromHeight(height ?? 36.0);
                },
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            onPressed: onPressed,
            child: child,
          ),
        ),
      ],
    );
  }
}
