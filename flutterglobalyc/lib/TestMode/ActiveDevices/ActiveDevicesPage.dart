import 'package:flutter/material.dart';
import 'package:flutterglobalyc/DatabaseHelper.dart';


import 'package:flutterglobalyc/TestMode/ActiveDevices/DeviceInfoPage.dart';
 final dbHelper = DatabaseHelper();
class ActiveDevicesPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController deviceNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
 return Scaffold(
  body: Padding(
    padding: const EdgeInsets.all(16.0),
    child: Container(
      width: 800,
      height: 1280,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(color: Color(0xFFF6F9FF)),
      child: Stack(
        children: [
          Positioned(
            left: 280,
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
            left: 170,
            top: 246,
            child: Container(
              width: 520,
              height: 596,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 520,
                      height: 596,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 1, color: Color(0xFFECF1FC)),
                          borderRadius: BorderRadius.circular(28),
                        ),
                        shadows: [
                          BoxShadow(
                            color: Color(0x19000000),
                            blurRadius: 15,
                            offset: Offset(0, 0),
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                    ),
                  ),
              Positioned(
                  left: 64,
                  top: 80,
                  child: SizedBox(
                    width: 392,
                    child: Text(
                      'Welcome to your new Zemits device!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 32,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        height: 1.2, // Bu değeri artırarak alt satıra geçişi kontrol edebilirsiniz
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),

            Positioned(
                        left: 80,
                        top: 176,
                        child: SizedBox(
                          width: 360,
                          child: Text(
                            'This registration need for activation your Warranty for Device',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF67697C),
                              fontSize: 16,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              height: 1.2, // Bu değeri artırarak alt satıra geçişi kontrol edebilirsiniz
                              letterSpacing: 0.5,
                             ),
                          ),
                        ),
                      ),
            Positioned(
                          left: 80,
                          top: 464,
                          child: SizedBox(
                            width: 360,
                            height: 52,
                            child: TextButton(
                              onPressed: () {
                                  
                              // TextField'lerden verileri al
                              final name = nameController.text;
                              final email = emailController.text;
                              final phoneNumber = phoneNumberController.text;

                              // Verileri bir harita olarak sakla
                              final data = {
                                'name': name,
                                'email': email,
                                'phonenumber': phoneNumber,
                                'devicestatus': true, // Aktivasyon durumu true olarak ayarlandı
                              };

                              // Veritabanına verileri ekle
                              dbHelper.insertData(data);

                              // Yeni sayfaya yönlendirme
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DeviceInfoPage(),
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
                                'Activate Device',
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

                    Positioned(
                      left: 80,
                      top: 324,
                      child: Container(
                        width: 360,
                        height: 56,
                        child: TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xFFF6F9FF),
                            labelText: 'Email',
                            labelStyle: TextStyle(
                              color: Color(0xFF67697C),
                              fontSize: 16,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              height: 0.09,
                              letterSpacing: 0.50,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),
                    ),


                    Positioned(
                      left: 80,
                      top: 256,
                      child: Container(
                        width: 360,
                        height: 56,
                        child: TextField(
                          controller: nameController,
                     
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xFFF6F9FF),
                            labelText: 'Full name',
                            labelStyle: TextStyle(
                              color: Color(0xFF67697C),
                              fontSize: 12,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              height: 0.11,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),
                    ),
                        Positioned(
                          left: 80,
                          top: 392,
                          child: Container(
                            width: 360,
                            height: 56,
                            child: TextField(
                              controller: phoneNumberController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xFFF6F9FF),
                                labelText: 'Phone number',
                                labelStyle: TextStyle(
                                  color: Color(0xFF67697C),
                                  fontSize: 16,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                  height: 0.09,
                                  letterSpacing: 0.50,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                          ),
                        ),

             
                ],
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


