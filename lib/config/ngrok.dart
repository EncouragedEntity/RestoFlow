// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

Future<Map<String, dynamic>> getTunnels() async {
  const myApiKey = '2VD136jTabE8TvIVfxSuTIwrcdJ_2n7JxpAi3b1s3SKT6Dfti';
  const apiKey = '2YFu7xK2abvOSEe61gTeNcReSQK_5tvDdnsfksPxbnJvUs5Dp';

  final url = Uri.parse('https://api.ngrok.com/tunnels');
  try {
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $myApiKey',
        'Ngrok-Version': '2',
      },
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return jsonData;
    } else {
      Logger().e('Error');
    }
  } on HandshakeException catch (e) {
    Logger().e(e.toString());
  }
  return {};
}

Future<String> getServerLink() async {
  try {
    final tunnels = await getTunnels();
    return tunnels['tunnels'][0]['public_url'];
  } on RangeError {
    throw Exception("Failed to retrieve tunnels data");
  }
}
