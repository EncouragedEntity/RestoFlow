import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_flow/blocs/auth_bloc.dart';
import 'package:resto_flow/events/auth_event.dart';
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
      style: TabStyle.react,
      initialActiveIndex: initialIndex,
      onTap: (index) {
        if (UserRepository.currentUser == null) {
          context.read<AuthBloc>().add(AuthSignOutEvent());
        }
        context.read<NavBloc>().add(NavEvent.values[index]);
      },
      items: const [
        TabItem(
          icon: Icon(Icons.restaurant_menu),
          title: 'Menu',
        ),
        TabItem(
          icon: Icon(Icons.menu),
          title: 'Order',
        ),
        TabItem(
          icon: Icon(Icons.qr_code_2),
          title: 'Scan QR',
        ),
        TabItem(
          icon: Icon(Icons.history),
          title: 'History',
        ),
        TabItem(
          icon: Icon(Icons.person),
          title: 'Profile',
        ),
      ],
    );
  }
}
