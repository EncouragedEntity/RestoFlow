import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_flow/blocs/auth_bloc.dart';
import 'package:resto_flow/events/auth_event.dart';
import 'package:resto_flow/generated/l10n.dart';
import 'package:resto_flow/repositories/user_repository.dart';

import '../blocs/nav_bloc.dart';
import '../events/nav_event.dart';

class NavBar extends StatelessWidget {
  const NavBar({
    super.key,
    this.initialIndex,
  });

  final int? initialIndex;
  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
      backgroundColor: Theme.of(context).primaryColor,
      style: TabStyle.react,
      initialActiveIndex: initialIndex,
      onTap: (index) {
        if (UserRepository.currentUser == null) {
          context.read<AuthBloc>().add(AuthSignOutEvent());
        }
        context.read<NavBloc>().add(NavEvent.values[index]);
      },
      items: [
        TabItem(
          icon: const Icon(
            Icons.restaurant_menu,
          ),
          title: S.of(context).menu_tab,
        ),
        TabItem(
          icon: const Icon(
            Icons.menu,
          ),
          title: S.of(context).order_tab,
        ),
        TabItem(
          icon: const Icon(
            Icons.qr_code_2,
          ),
          title: S.of(context).qr_tab,
        ),
        TabItem(
          icon: const Icon(
            Icons.history,
          ),
          title: S.of(context).history_tab,
        ),
        TabItem(
          icon: const Icon(
            Icons.person,
          ),
          title: S.of(context).profile_tab,
        ),
      ],
    );
  }
}
