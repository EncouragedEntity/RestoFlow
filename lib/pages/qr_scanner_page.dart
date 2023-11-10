import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:resto_flow/blocs/events/order_event.dart';
import 'package:resto_flow/blocs/nav_bloc.dart';
import 'package:resto_flow/blocs/order_bloc.dart';
import 'package:resto_flow/blocs/states/order_state.dart';
import 'package:resto_flow/data/string_constants.dart';

import '../blocs/events/nav_event.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  String scanResult = "";
  QRViewController? controller;
  bool didScanCode = false;

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      if (BlocProvider.of<OrderBloc>(context).state is OrderTableSetState) {
        context.read<NavBloc>().add(NavEvent.menu);
        return;
      }

      if (didScanCode) {
        return;
      }

      didScanCode = true;

      scanResult = scanData.code ?? "";
      if (!scanResult.startsWith(qrPrefix)) {
        didScanCode = false;
        Logger().e("$scanResult does not start with $qrPrefix");
        if (!ScaffoldMessenger.of(context).mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Could't read qr code"), //TODO change to locale
            ),
          );
        }
        return;
      }

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
      ],
    );
  }
}
