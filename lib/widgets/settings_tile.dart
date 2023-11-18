import 'package:flutter/material.dart';

class SettingsTile extends StatelessWidget {
  const SettingsTile({
    super.key,
    this.title,
    required this.trailing,
    this.showDivider = true,
    this.width,
  });

  final Widget? title;
  final Widget trailing;
  final bool showDivider;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (title != null) title!,
            if (width == null)
              trailing
            else
              SizedBox(
                width: width,
                child: trailing,
              ),
          ],
        ),
        if (showDivider)
          Divider(
            color: Theme.of(context).dividerColor,
          ),
      ],
    );
  }
}
