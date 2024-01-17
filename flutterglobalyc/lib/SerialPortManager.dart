import 'package:flutter/services.dart';

class SerialPortManager {
  static const MethodChannel _channel = MethodChannel('serial_port_channel');

  Future<void> openSerialPort() async {
    // try {
    //   await _channel.invokeMethod('openSerialPort');
    // } catch (e) {
    //   print("Seri port açılırken hata oluştu: $e");
    
    // }
  }

  Future<void> closeSerialPort() async {
    // try {
    //   await _channel.invokeMethod('closeSerialPort');
    // } catch (e) {
    //   print("Seri port kapatılırken hata oluştu: $e");
    //   // Hata oluştuğunda yapılacak işlemler...
    // }
  }

  Future<void> sendData(String data) async {
    // try {
    //   await _channel.invokeMethod('sendData', {'data': data});
    // } catch (e) {
    //   print("Seri porta veri gönderilirken hata oluştu: $e");
    //   // Hata oluştuğunda yapılacak işlemler...
    // }
  }

  Future<String> readData() async {
   try {
       final String receivedData = await _channel.invokeMethod('readData');
       return receivedData;
     } catch (e) {
       print("Veri okunurken hata oluştu: $e");
       return "Hata: Veri okunamadı";
     }
  }
}
