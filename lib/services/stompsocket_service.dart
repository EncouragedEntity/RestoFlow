import 'dart:async';
import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:resto_flow/repositories/user_repository.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

import '../models/products/order_product_dto.dart';
import '../models/products/product.dart';
import '../models/products/push_order_dto.dart';
import '../models/products/socket_product.dart';

class StompSocketService {
  final String serverLink = UserRepository.instance?.hostname ?? "";
  final String tableId;
  final void Function(StompFrame) onCallback;
  late StompClient _stompClient;
  String get hostname => serverLink.substring(serverLink.indexOf('/') + 2);

  static bool isSocketConnected = false;
  static StompSocketService? instance;

  static void disconnectStatic() => instance?.disconnect();

  final _productStreamController =
      StreamController<List<OrderProductDto>>.broadcast();

  Stream<List<OrderProductDto>> get productStream =>
      _productStreamController.stream;

  final Stopwatch _timer = Stopwatch();

  StompSocketService._internal({
    required this.tableId,
    required this.onCallback,
  });

  factory StompSocketService({
    required String tableId,
    required void Function(StompFrame) onCallback,
  }) {
    instance ??= StompSocketService._internal(
      tableId: tableId,
      onCallback: onCallback,
    );

    return instance!;
  }

  Future<void> connect() async {
    if (isSocketConnected) {
      disconnect();
      await connect();
    }

    try {
      _stompClient = StompClient(
        config: StompConfig(
          url: 'wss://$hostname/api/dine/public/websocket-endpoint',
          onConnect: onConnect,
          onWebSocketError: onWebSocketError,
          onStompError: onStompError,
          onWebSocketDone: () async {
            _timer.stop();

            Logger().w(
                "Socket is done after ${_timer.elapsedMilliseconds / 1000}s. of work");
            _timer.reset();
            disconnect();
            await connect();
          },
          onDisconnect: onDisconnect,
          beforeConnect: () async {
            Logger().w("I`m about to connect");
          },
          stompConnectHeaders: {
            'User-Agent': 'PostmanRuntime/7.34.0',
            'ngrok-skip-browser-warning': '69420',
            'Connection': 'upgrade',
            'Upgrade': 'websocket',
            'heart-beat': '5000,5000',
          },
        ),
      );

      try {
        _stompClient.activate();
        Logger().w('Stomp Client Activated');
      } on Exception catch (e) {
        Logger().e(e.toString());
      }

      await Future.delayed(const Duration(seconds: 1));

      _stompClient.subscribe(
        destination: '/topic/order/$tableId',
        callback: onCallback,
      );

      isSocketConnected = true;
    } on Exception catch (e) {
      isSocketConnected = false;
      Logger().e(e.toString());
    }
  }

  List<Product> parseProducts(String body) {
    List<dynamic> jsonList = jsonDecode(body);
    List<Product> products =
        jsonList.map((json) => Product.fromJson(json)).toList();
    return products;
  }

  void addProductsToOrder(List<Product> products) {
    if (isSocketConnected) {
      final socketProducts = products
          .map(
            (product) => SocketProductData(
              product.id,
              products.where((element) => element.id == product.id).length,
            ),
          )
          .toList();

      final pushOrderDto = PushOrderDto(
        socketProducts,
        UserRepository.currentUser?.id,
      );

      _stompClient.send(
        destination: '/app/order/$tableId',
        body: pushOrderDto.toJsonString(),
        headers: {
          "Content-Type": "application/json",
          "content-length": pushOrderDto.toJsonString().length.toString(),
        },
      );
    } else {
      throw Exception("Not connected");
    }
  }

  void removeProductsFromOrder(List<Product> products) {
    if (isSocketConnected) {
      final socketProducts = products
          .map(
            (product) => SocketProductData(
              product.id,
              products.where((element) => element.id == product.id).length,
            ),
          )
          .toList();
      final string = jsonEncode(socketProducts);

      _stompClient.send(
        destination: '/app/order/remove/$tableId',
        body: string,
        headers: {
          "Content-Type": "application/json",
          "content-length": string.length.toString(),
        },
      );
    } else {
      throw Exception("Not connected");
    }
  }

  void deleteProductFromOrder(int productId, int quantity) {
    if (isSocketConnected) {
      final socketProduct = [SocketProductData(productId, quantity)];

      final string = jsonEncode(socketProduct);

      _stompClient.send(
        destination: '/app/order/remove/$tableId',
        body: string,
        headers: {
          "Content-Type": "application/json",
          "content-length": string.length.toString(),
        },
      );
    } else {
      throw Exception("Not connected");
    }
  }

  void sendMockRequest() async {
    final string = jsonEncode([SocketProductData(0, 0)]);

    _stompClient.send(
      destination: '/app/order/remove/$tableId',
      body: string,
      headers: {
        "Content-Type": "application/json",
        "content-length": string.length.toString(),
      },
    );

    await Future.delayed(const Duration(milliseconds: 2000));
  }

  void setOrderStatus(String newStatus) async {
    _stompClient.send(
      destination: '/app/order/status/$tableId',
      body: "\"$newStatus\"",
      headers: {
        "Content-Type": "application/json",
        "content-length": newStatus.length.toString(),
      },
    );

    await Future.delayed(const Duration(milliseconds: 500));
  }

  void onConnect(StompFrame connectFrame) {
    _timer.start();
    Logger().i(
        'Connected successfully with ${connectFrame.command} command @ $hostname');
    isSocketConnected = true;
  }

  void onWebSocketError(dynamic error) {
    Logger().e('WebSocket Error: $error');
    isSocketConnected = false;
  }

  void onStompError(dynamic error) {
    Logger().e('STOMP Error: $error');
    isSocketConnected = false;
  }

  void onDisconnect(StompFrame frame) {
    Logger().w('I`m about to disconnect ${frame.body}');
    isSocketConnected = false;
  }

  void disconnect() {
    _stompClient.deactivate();
    isSocketConnected = false;
  }
}
