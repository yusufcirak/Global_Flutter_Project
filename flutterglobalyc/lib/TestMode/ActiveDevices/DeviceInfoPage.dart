import 'package:flutter/material.dart';
import 'package:flutterglobalyc/TestMode/ActiveDevices/WifiPage.dart';

class DeviceInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
           appBar: AppBar(
          title: Text('Active Devices'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          width: 1280,
          height: 800,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Color(0xFFF6F9FF)),
          child: Stack(
            children: [
              Positioned(
                
                left: 375,
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
                ),
              ),
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
                left: 520,
                top: 220,
                child: Container(
                  width: 240,
                  height: 240,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("lib/images/activedevicesimage.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 430,
                top: 500  ,
                child: SizedBox(
                  width: 392,
                  child: Text(
                    'YOUR DEVICE',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF67697C),
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w600,
                      height: 0.08,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 430,
                top: 550,
                child: SizedBox(
                  width: 392,
                  child: Text(
                    'Zemits Lillie NG',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 32,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                      height: 0.04,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 450,
                top: 575,
                child: SizedBox(
                  width: 360,
                  height: 52,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WifiPage(),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF1559C4)),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                    child: Text(
                      'Connect to Wi-Fi',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.50,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(DeviceInfoPage());
}
