import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:resto_flow/data/string_constants.dart';
import 'package:resto_flow/models/payment/payment_result.dart';
import 'package:resto_flow/repositories/order_repository.dart';
import 'package:resto_flow/repositories/table_repository.dart';
import 'package:resto_flow/repositories/user_repository.dart';

import '../models/order/order.dart';
import '../models/payment/card_details.dart';
import '../models/payment/payment_dto.dart';
import '../models/table.dart';
import '../services/stompsocket_service.dart';

class PaymentRepository {
  final storage = const FlutterSecureStorage();
  final key = "cardDetails";

  Future<bool> get areDetailsSaved async {
    if (await loadDetails != null) {
      return true;
    }
    return false;
  }

  Future<CardDetails?> get loadDetails async {
    final result = await storage.read(key: key) ?? "";
    if (result.isEmpty) return null;
    return CardDetails.fromJson(jsonDecode(result));
  }

  void saveDetails(CardDetails details) async {
    await storage.write(
      key: key,
      value: details.toJsonString(),
    );
  }

  void clearDetails() async {
    await storage.delete(key: key);
  }

  Future<PaymentResult> payTheCheck(
      CardDetails card, String? email, int? userId, double amount) async {
    final paymentDto = PaymentDto(
      orderId: OrderRepository().currentOrder?.id ?? 0,
      amount: amount,
      card: card.digits,
      cardExpMonth: card.expMonth,
      cardExpYear: card.expYear,
      cardCvv: card.cvv,
    );

    // ignore: unused_local_variable
    final body = paymentDto.toJson();
    final bodyString = paymentDto.toJsonString();

    final response = await http.post(
      Uri.parse(UserRepository.instance!.hostname! + payment),
      headers: {
        "userId": userId.toString(),
        "email": email ?? "",
        "Content-type": "application/json",
      },
      body: bodyString,
    );

    if (response.statusCode == 200) {
      Table table =
          await TableRepository(hostname: UserRepository.instance!.hostname!)
              .getById(OrderRepository().currentOrder!.tableId);

      OrderRepository().currentOrder = Order(
        tableId: table.id,
        restaurantId: table.restaurantId,
        status: orderStatusChoosing,
      );
      OrderRepository().products = List.empty(growable: true);

      StompSocketService.instance!.sendMockRequest();

      return PaymentResult.success;
    }
    return PaymentResult.failure;
  }
}
