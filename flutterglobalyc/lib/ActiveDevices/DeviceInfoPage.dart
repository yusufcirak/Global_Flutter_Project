import 'package:flutter/material.dart';
import 'package:flutterglobalyc/ActiveDevices/WifiPage.dart';

class DeviceInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 800,
        height: 1280,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(color: Color(0xFFF6F9FF)),
        child: Stack(
          children: [
            Positioned(
              left: 200,
              top: 250,
              child: Container(
                width: 520,
                height: 594,
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
            left: 278,
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
  left: 340,
  top: 300,
  child: Container(
    width: 240,
    height: 240,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage("lib/images/activedevicesimage.png"), // Resminizin adını doğru şekilde vermelisiniz
        fit: BoxFit.cover,
      ),
    ),
  ),
),

            Positioned(
              left: 255,
              top: 598,
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
              left: 265,
              top: 628,
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
                                left: 280,
            top: 708,
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
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: DeviceInfoPage(),
  ));
}
