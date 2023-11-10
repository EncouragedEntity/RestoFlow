import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_flow/blocs/auth_bloc.dart';
import 'package:resto_flow/blocs/events/product_event.dart';
import 'package:resto_flow/blocs/nav_bloc.dart';
import 'package:resto_flow/blocs/order_bloc.dart';
import 'package:resto_flow/blocs/product_bloc.dart';
import 'package:resto_flow/blocs/states/order_state.dart';
import 'package:resto_flow/blocs/states/product_state.dart';
import 'package:resto_flow/pages/order/order_history.dart';
import 'package:resto_flow/pages/order/order_page.dart';
import 'package:resto_flow/pages/products/product_home_page.dart';
import 'package:resto_flow/pages/profile_page.dart';
import 'package:resto_flow/pages/qr_scanner_page.dart';
import 'package:resto_flow/blocs/states/auth_state.dart';

import '../widgets/navbar.dart';
import 'auth/login_page.dart';
import 'auth/signup_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 2;
  @override
  void initState() {
    super.initState();
  }

  final GlobalKey<ConvexAppBarState> _appBarKey =
      GlobalKey<ConvexAppBarState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (authCtx, authState) {
          return BlocBuilder<NavBloc, int>(
            builder: (navCtx, navState) {
              Widget currentPage = const ScannerPage();
              if (authState is AuthLoading) {
                currentPage = Center(
                  child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor),
                );
              } else if (authState is AuthLoggingIn) {
                currentPage = const LoginPage();
              } else if (authState is AuthSigningUp) {
                currentPage = const SignUpPage();
              } else {
                if (navState == 0) {
                  final productState =
                      BlocProvider.of<ProductBloc>(context).state;
                  final orderState = BlocProvider.of<OrderBloc>(context).state;
                  if (productState is ProductLoading &&
                      orderState is OrderTableSetState) {
                    context.read<ProductBloc>().add(ProductShowAllEvent());
                  }
                  currentPage = ProductHomePage(appBarKey: _appBarKey);
                  if (selectedIndex != 0) {
                    _appBarKey.currentState?.animateTo(0);
                  }
                  selectedIndex = 0;
                } else if (navState == 1) {
                  currentPage = OrderPage(
                    appBarKey: _appBarKey,
                  );
                  selectedIndex = 1;
                } else if (navState == 2) {
                  currentPage = const ScannerPage();
                  selectedIndex = 2;
                } else if (navState == 3) {
                  currentPage = OrderHistoryPage(appBarKey: _appBarKey);
                  selectedIndex = 3;
                } else if (navState == 4) {
                  currentPage = const ProfilePage();
                  selectedIndex = 4;
                }
              }
              return Column(
                children: [
                  Expanded(
                    child: currentPage,
                  ),
                  NavBar(
                    initialIndex: selectedIndex,
                    appBarKey: _appBarKey,
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
