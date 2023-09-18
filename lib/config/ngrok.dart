import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

Future<Map<String, dynamic>> getTunnels() async {
  const apiKey = '2VD136jTabE8TvIVfxSuTIwrcdJ_2n7JxpAi3b1s3SKT6Dfti';
  final url = Uri.parse('https://api.ngrok.com/tunnels');
  final response = await http.get(
    url,
    headers: {
      'Authorization': 'Bearer $apiKey',
      'Ngrok-Version': '2',
    },
  );
  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);
    return jsonData;
  } else {
    Logger().log(Level.error, 'Error');
    return {};
  }
}

Future<String> getServerLink() async {
  try {
    final tunnels = await getTunnels();
    return tunnels['tunnels'][0]['public_url'];
  } on RangeError {
    throw Exception("Failed to retrieve tunnels data");
  }
}
