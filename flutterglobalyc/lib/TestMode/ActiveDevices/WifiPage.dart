import 'package:flutter/material.dart';
import 'package:wifi_iot/wifi_iot.dart';
import 'package:flutterglobalyc/TestMode/ActiveDevices/PersonalCodePage.dart';

class WifiPage extends StatefulWidget {
  @override
  _WifiPageState createState() => _WifiPageState();
}

class _WifiPageState extends State<WifiPage> {

  
  List<WifiNetwork> _wifiNetworks = [];
  String _selectedSSID = '';
  TextEditingController _passwordController = TextEditingController();
  bool _connecting = false;

  @override
  void initState() {
    super.initState();
    _loadWifiNetworks();
  }

  void _loadWifiNetworks() async {
    try {
      final List<WifiNetwork> wifiList = await WiFiForIoTPlugin.loadWifiList();
      setState(() {
        _wifiNetworks = wifiList;
      });
    } on Exception catch (e) {
      print("Error loading Wi-Fi networks: $e");
    }
  }

  void _connectToWifi(String ssid, String password) async {
    if (ssid.isNotEmpty) {
      try {
        setState(() {
          _connecting = true;
        });

        final result = await WiFiForIoTPlugin.connect(
          ssid,
          password: password,
          security: NetworkSecurity.WPA,
          joinOnce: false,
        );

        setState(() {
          _connecting = false;
        });

        if (result) {
          print('Connection successful.');
          // Bağlantı başarılıysa, yeni sayfaya geçiş yap
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => PersonalCodePage(),
            ),
          );
        } else {
          print('Connection failed.');
          // Bağlantı hatası mesajı buraya eklenebilir
        }
      } on Exception catch (e) {
        print("Connection error: $e");
        setState(() {
          _connecting = false;
        });
      }
    } else {
      print('Invalid Wi-Fi network.');
      // Kullanıcıya bildirim veya uyarı gösterebilirsiniz
    }
  }

  Future<void> _showPasswordDialog(String ssid) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$ssid'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          content: Container(
            width: 350,
            height: 80,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Text(
                    'Please enter password for this Wi-Fi',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF67697C),
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      height: 0.10,
                      letterSpacing: 0.25,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    obscureText: true,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFF6F9FF),
                      labelText: 'Enter Password',
                      labelStyle: TextStyle(
                        color: Color(0xFF67697C),
                        fontSize: 12,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        height: 0.11,
                        letterSpacing: 0.50,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dialog'u kapat
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: _connecting
                  ? null
                  : () {
                      _connectToWifi(ssid, _passwordController.text);
                    },
              child: Container(
                width: 120,
                height: 40,
                alignment: Alignment.center,
                child: _connecting
                    ? CircularProgressIndicator()
                    : Text(
                        'Connect',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.10,
                        ),
                      ),
              ),
            ),
          ],
        );
      },
    );
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title: Text('Active Devices'),
           centerTitle: true,
      ),
      body: Container(
        width: 1280,
        height: 800,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(color: Color(0xFFF6F9FF)),
        child: Stack(
          children: [
            Positioned(
                left: 500,
                top: 104,
                child: Container(
                  width: 244,
                  height: 62,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
                  child: Image.asset(
                    'lib/images/zlogo.png',
                    width: 400,
                    height: 400,
                  ),
                ),
              ),
            Positioned(
              left: 400,
              right: 400,
              top: 200,
              child: Container(
                width: 520,
                height: 500,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: Color(0xFFE0E7F6)),
                    borderRadius: BorderRadius.circular(28),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(0x19000000),
                      blurRadius: 15,
                      offset: Offset(0, 0),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50,
                    
                    ),
                    
                    SizedBox(height: 20),
                    Text(
                      'Choice your Wi-Fi',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 32,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        height: 0.08,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Please connect device for Wi-Fi network for Activate',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF67697C),
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w600,
                        height: 0.08,
                      ),
                    ),
                    SizedBox(height: 20),
                    if (_wifiNetworks.isNotEmpty)
                     Expanded(
  child: ListView.builder(
    itemCount: _wifiNetworks.length,
    itemBuilder: (context, index) {
      final wifiNetwork = _wifiNetworks[index];
      return Container(
        color: Colors.white, // Arka plan rengi
        child: Card(
                  color: Color(0xFFE0E7F6),
          elevation: 3,
          child: ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(wifiNetwork.ssid ?? ''),
                ElevatedButton(
                  onPressed: _connecting
                      ? null
                      : () {
                          setState(() {
                            _selectedSSID = wifiNetwork.ssid ?? '';
                          });
                          _showPasswordDialog(_selectedSSID);
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF1559C4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Container(
                    width: 80,
                    height: 30,
                    alignment: Alignment.center,
                    child: _connecting
                        ? CircularProgressIndicator()
                        : Text(
                            'Connect',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.10,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  ),
)

                    else
                      Center(
                        child: Text(
                          'Wi-Fi network not found.',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



void main() {
  runApp(MaterialApp(
    home: WifiPage(),
  ));
}
