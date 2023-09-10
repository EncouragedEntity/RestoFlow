import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'config/ngrok.dart';

void main() async {
  final link = await getServerLink();

  try {
    Logger().log(
      Level.info,
      'App starts here',
    );
  } catch (e) {
    Logger().log(
      Level.error,
      e.toString(),
    );
  }

  runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Text(
          link,
          style: const TextStyle(color: Colors.black),
        ),
      ),
    ),
  );
}
