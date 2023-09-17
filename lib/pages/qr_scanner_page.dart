import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../blocs/auth_bloc.dart';
import '../events/auth_event.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({Key? key}) : super(key: key);

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  bool shouldShowInstructions = true;

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
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
    return GestureDetector(
      onTap: () {
        setState(() {
          shouldShowInstructions = false;
        });
      },
      child: Stack(
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
                if (shouldShowInstructions)
                  const Text(
                    "Tap to scan",
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
              ],
            ),
          ),
          Positioned(
            right: 10,
            child: SafeArea(
              child: ElevatedButton.icon(
                onPressed: () {
                  context.read<AuthBloc>().add(AuthWantToLogInEvent());
                },
                label: const Text('Login'),
                icon: const Icon(Icons.login),
              ),
            ),
          )
        ],
      ),
    );
  }
}
