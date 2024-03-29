import 'package:flutter/material.dart';
import 'package:wifi_iot/wifi_iot.dart';
import 'package:flutterglobalyc/TestMode/QATestingMode/QaModeSDevice.dart';



class QaModeLogin extends StatefulWidget {
  @override
  _QaModeLoginState createState() => _QaModeLoginState();
}

class _QaModeLoginState extends State<QaModeLogin> {
  final String wifiSsid = "AndroidWifi"; // Bağlanılacak Wi-Fi ağının SSID'si
  final String wifiPassword = ""; // Wi-Fi şifresi
  bool _isConnected = false;
    bool btnVisibalty=false;

  @override
  void initState() {
    super.initState();
    _checkWifiConnection();
  }

  void _checkWifiConnection() async {
    bool isConnected = await WiFiForIoTPlugin.isConnected();
    setState(() {
      _isConnected = isConnected;
      if(_isConnected){
        btnVisibalty=false;
      }else{
        btnVisibalty=true;
      }
    });
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
                    'QA Testing Mode',
                    style: TextStyle(fontSize: 30, color: Colors.black),
                  ),
                ),
                SizedBox(height: 50.0),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                     _isConnected
                          ? Icons.wifi
                          : Icons.warning,
                      size: 100,
                      color: const Color.fromARGB(255, 54, 53, 53),
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      _isConnected
                          ? 'Wi-Fi Connected!'
                          : 'Wi-Fi Disconnected! Please check Wi-Fi router \nSSID - $wifiSsid',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ],
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
                            builder: (context) => QaModeSDevice(),
                        ),
                      );
                    } else {
                      _connectToWifi();
                    }
                  
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(width: 2.0, color: Colors.blue),
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  ),
                  child: Text(

                      _isConnected
                          ? 'Continue'
                          : 'Search Wifi',
                   
                    style: TextStyle(fontSize: 18, color: Colors.blue),
                  ),
                ),
               SizedBox(width: 20.0),
                 Visibility(
                  visible: btnVisibalty, 
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QaModeSDevice(),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(width: 2.0, color: Colors.blue),
                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
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
    home: QaModeLogin(),
  ));
}
