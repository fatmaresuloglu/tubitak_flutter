// ignore_for_file: avoid_print, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late MqttServerClient client;
  String receivedMessage = "Bağlantı bekleniyor...";

  @override
  void initState() {
    super.initState();
    connectToAzure();
  }

  Future<void> connectToAzure() async {
    client = MqttServerClient.withPort(
        'ESP32proje.azure-devices.net', 'FlutterClient', 8883);
    client.logging(on: true);
    client.keepAlivePeriod = 60;
    client.secure = true;
    client.setProtocolV311();
    client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;

    final connMessage = MqttConnectMessage()
        .withClientIdentifier('FlutterClient')
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);
    client.connectionMessage = connMessage;

    try {
      await client.connect();
    } catch (e) {
      // ignore: avoid_print
      print('Bağlantı hatası: $e');
    }

    client.subscribe(
        'devices/ESP32Device/messages/events/', MqttQos.atMostOnce);
    client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final MqttPublishMessage recMess = c![0].payload as MqttPublishMessage;
      final String pt =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      setState(() {
        receivedMessage = pt;
      });
    });
  }

  void onConnected() {
    // ignore: avoid_print
    print('Azure IoT Hub a bağlandı!');
  }

  void onDisconnected() {
    print('Bağlantı kesildi!');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text("Azure IoT Hub Verileri")),
        body: Center(
          child: Text(receivedMessage, style: const TextStyle(fontSize: 20)),
        ),
      ),
    );
  }
}
