import 'package:flutter/services.dart';

class SerialPortManager {
  static const MethodChannel _channel = MethodChannel('serial_port_channel');

  Future<void> openSerialPort() async {
    await _channel.invokeMethod('openSerialPort');
  }

  Future<void> closeSerialPort() async {
    await _channel.invokeMethod('closeSerialPort');
  }

  Future<void> sendData(String data) async {
    await _channel.invokeMethod('sendData', {'data': data});
  }

  Future<String> readData() async {
    final String receivedData = await _channel.invokeMethod('readData');
    return receivedData;
  }
}
