import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_flow/widgets/page_blocker.dart';

import '../blocs/auth_bloc.dart';
import '../blocs/states/auth_state.dart';
import '../generated/l10n.dart';

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({super.key, required this.appBarKey});

  final GlobalKey<ConvexAppBarState> appBarKey;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (ctx, state) {
        if (state is AuthAuthenticated) {
          return const Center(child: Text("History here"));
        }
        return PageBlocker(
          appBarKey: appBarKey,
          destinationIndex: 4,
          text: S.current.login_first,
          buttonText: S.current.go_to_login,
        );
      },
    );
  }
}
