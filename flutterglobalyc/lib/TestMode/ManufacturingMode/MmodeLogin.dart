import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wifi_iot/wifi_iot.dart';
import 'package:flutterglobalyc/TestMode/ManufacturingMode/MmodeSDevice.dart';
import 'package:flutterglobalyc/DatabaseHelperUpdate.dart';
import 'package:package_info/package_info.dart';
import 'package:flutterglobalyc/SerialPortManager.dart';

class MmodeLogin extends StatefulWidget {
  @override
  _MmodeLoginState createState() => _MmodeLoginState();
}


class _MmodeLoginState extends State<MmodeLogin> {
    final serialPortManager = SerialPortManager();
  final String wifiSsid = "EstheticCA1"; //add wifi ssid
  final String wifiPassword = "8889993996";       //add wifi pass
  bool _isConnected = false;
  bool btnVisibility = false;
  String receivedData = "";

   // StreamController for Wi-Fi connection status
  StreamController<bool> _wifiConnectionStreamController =
      StreamController<bool>();


  @override
  void initState() {
    super.initState();
    _initPackageInfo();
    _checkWifiConnection();

    serialPortManager.openSerialPort();
    serialPortManager.readData().then((value) {
      setState(() {
        receivedData = value;
        print(receivedData);
      });
    });
  }
   void _initPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String softwareVersion = packageInfo.version;

    // Veritabanına software version bilgisini kaydet
    saveSoftwareVersion(softwareVersion,wifiSsid, wifiPassword);
  }
   void saveSoftwareVersion(String softwareVersion,String ssid, String password) async {
    DatabaseHelperUpdate dbHelper = DatabaseHelperUpdate();
    Map<String, dynamic> row = {
      'softwareVersion': softwareVersion,
          'wifiSsid': ssid,
        'wifiPass': password,
    };
    await dbHelper.insertUpdate(row);
  }

   void _checkWifiConnection() async {
    bool isConnected = await WiFiForIoTPlugin.isConnected();
    setState(() {
      _isConnected = isConnected;
      if (_isConnected) {
        btnVisibility = false;
      } else {
        btnVisibility = true;
      }
    });

    // Update the Wi-Fi connection status in the stream
    _wifiConnectionStreamController.add(_isConnected);
  }

  void _connectToWifi() async {
    try {
      await WiFiForIoTPlugin.connect(
        wifiSsid,
        password: wifiPassword,
        security: NetworkSecurity.WPA,
        joinOnce: true,
      );
      _checkWifiConnection(); // Bağlantı sonrasında durumu kontrol et

     
    } catch (e) {
      print("Error connecting to Wi-Fi: $e");
    }
  }
    @override
  void dispose() {
      _wifiConnectionStreamController.close(); // Close the stream controller
    super.dispose();
  }
@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Image.asset(
                'lib/images/zlogo.png',
                width: 100,
                height: 100,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 130.0),
                  child: Text(
                    'Manufacturing Mode',
                    style: TextStyle(fontSize: 30, color: Colors.black),
                  ),
                ),
                SizedBox(height: 50.0),
                StreamBuilder<bool>(
                  stream: _wifiConnectionStreamController.stream,
                  initialData: false,
                  builder: (context, snapshot) {
                    bool isConnected = snapshot.data ?? false;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          isConnected ? Icons.wifi : Icons.warning,
                          size: 100,
                          color: const Color.fromARGB(255, 54, 53, 53),
                        ),
                        SizedBox(width: 10.0),
                        Text(
                          isConnected
                              ? 'Wi-Fi Connected!'
                              : 'Wi-Fi Disconnected! Please check Wi-Fi router \nSSID - $wifiSsid',
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        if (_isConnected) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MmodeSDevice(),
                            ),
                          );
                        } else {
                          _connectToWifi();
                        }
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(width: 2.0, color: Colors.blue),
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                      ),
                      child: Text(
                        _isConnected ? 'Continue' : 'Search Wifi',
                        style: TextStyle(fontSize: 18, color: Colors.blue),
                      ),
                    ),
                    SizedBox(width: 20.0),
                    Visibility(
                      visible: btnVisibility,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MmodeSDevice(),
                            ),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(width: 2.0, color: Colors.blue),
                          padding:
                              EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                        ),
                        child: Text(
                          'Offline Continue',
                          style: TextStyle(fontSize: 18, color: Colors.blue),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  
}


void main() {
  runApp(MaterialApp(
    home: MmodeLogin(),
  ));
}
