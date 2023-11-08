import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_flow/widgets/my_themed_button.dart';

import '../blocs/events/nav_event.dart';
import '../blocs/nav_bloc.dart';

class PageBlocker extends StatelessWidget {
  const PageBlocker({
    super.key,
    required this.appBarKey,
    required this.destinationIndex,
    required this.text,
    required this.buttonText,
  });

  final GlobalKey<ConvexAppBarState> appBarKey;
  final int destinationIndex;
  final String text;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      constraints: const BoxConstraints(
        maxWidth: 280,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(text),
          const SizedBox(
            height: 20,
          ),
          MyThemedButton(
            height: 40,
            onPressed: () {
              context.read<NavBloc>().add(NavEvent.values[destinationIndex]);
              appBarKey.currentState?.animateTo(destinationIndex);
            },
            child: Text(buttonText),
          ),
        ],
      ),
    ));
  }
}
