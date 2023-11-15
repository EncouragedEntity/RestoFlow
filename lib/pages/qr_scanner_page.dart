import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:restart_app/restart_app.dart';
import 'package:resto_flow/blocs/events/order_event.dart';
import 'package:resto_flow/blocs/nav_bloc.dart';
import 'package:resto_flow/blocs/order_bloc.dart';
import 'package:resto_flow/blocs/states/order_state.dart';
import 'package:resto_flow/data/string_constants.dart';
import 'package:resto_flow/widgets/my_themed_button.dart';

import '../blocs/events/nav_event.dart';
import '../generated/l10n.dart';
import '../repositories/order_repository.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  String scanResult = "";
  QRViewController? controller;

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      if (BlocProvider.of<OrderBloc>(context).state is OrderTableSetState) {
        context.read<NavBloc>().add(NavEvent.menu);
        return;
      }

      scanResult = scanData.code ?? "";
      if (!scanResult.startsWith(qrPrefix)) {
        Logger().e("$scanResult does not start with $qrPrefix");
        if (ScaffoldMessenger.of(context).mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor:
                  Theme.of(context).scaffoldBackgroundColor.withGreen(100),
              content: Text(
                S.current.qr_scan_error,
                style: TextStyle(
                  color: Theme.of(context).highlightColor,
                ),
              ),
            ),
          );
        }
        return;
      }

      ScaffoldMessenger.of(context).clearSnackBars();

      final tableId = scanResult.substring(10);

      setState(() {
        if (BlocProvider.of<OrderBloc>(context).state
            is OrderTableNotSetState) {
          context.read<OrderBloc>().add(
                OrderSetTableEvent(tableId: tableId),
              );
        }
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        QRView(
          key: qrKey,
          onQRViewCreated: _onQRViewCreated,
        ),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                    border: Border.all(
                      color: const Color.fromARGB(255, 176, 176, 176),
                      width: 2.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (OrderRepository().currentOrder?.tableId.isNotEmpty ?? false)
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 300),
              child: Container(
                constraints: const BoxConstraints(
                  maxWidth: 150,
                ),
                child: MyThemedButton(
                  onPressed: () {
                    Restart.restartApp();
                  },
                  child: Text(S.current.reset_table),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
