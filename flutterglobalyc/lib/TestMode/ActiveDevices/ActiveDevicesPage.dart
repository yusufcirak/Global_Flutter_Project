import 'package:flutter/material.dart';
import 'package:flutterglobalyc/DatabaseHelper.dart';
import 'package:flutterglobalyc/TestMode/ActiveDevices/DeviceInfoPage.dart';

final dbHelper = DatabaseHelper();

class ActiveDevicesPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(color: Color(0xFFF6F9FF)),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'lib/images/zlogo.png',
                  width: 200,
                  height: 200,
                ),
              ],
            ),
          ),
          Positioned(
            top: 150,
            left: 400,
            right: 400,
            child: Container(
              width: 500,
              height: 500,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(width: 1, color: Color(0xFFECF1FC)),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x19000000),
                    blurRadius: 15,
                    offset: Offset(0, 0),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Welcome to your new \nZemits device!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'This registration is needed for activating your\n Warranty for Device .',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF67697C),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 40),
                    Container(
                      width: 200,
                      height: 56,
                      child: TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFF6F9FF),
                          labelText: 'Full Name',
                          labelStyle: TextStyle(
                            color: Color(0xFF67697C),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 200,
                      height: 56,
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFF6F9FF),
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            color: Color(0xFF67697C),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 200,
                      height: 56,
                      child: TextField(
                        controller: phoneNumberController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFF6F9FF),
                          labelText: 'Phone Number',
                          labelStyle: TextStyle(
                            color: Color(0xFF67697C),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        // TextField'lerden verileri al
                        final name = nameController.text;
                        final email = emailController.text;
                        final phoneNumber = phoneNumberController.text;

                        // Veri boş olup olmadığını kontrol et
                        if (name.isEmpty || email.isEmpty || phoneNumber.isEmpty) {
                          // Boşsa bir uyarı gösterebilirsiniz
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Warning"),
                                content: Text("Please fill in all fields."),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("OK"),
                                  ),
                                ],
                              );
                            },
                          );
                          return;
                        }

                        // E-posta formatını kontrol et
                        if (!isValidEmail(email)) {
                          // Hatalıysa bir uyarı gösterebilirsiniz
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Warning"),
                                content: Text("Please enter a valid email address."),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("OK"),
                                  ),
                                ],
                              );
                            },
                          );
                          return;
                        }

                        // Telefon numarası formatını kontrol et (istediğiniz gibi güncelleyebilirsiniz)
                        if (!isValidPhoneNumber(phoneNumber)) {
                          // Hatalıysa bir uyarı gösterebilirsiniz
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Warning"),
                                content: Text("Please enter a valid phone number."),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("OK"),
                                  ),
                                ],
                              );
                            },
                          );
                          return;
                        }

                        // Verileri bir harita olarak sakla
                        final data = {
                          'name': name,
                          'email': email,
                          'phonenumber': phoneNumber,
                          'devicestatus': true,
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
                      child: Container(
                        width: 150,
                        height: 30,
                        child: Center(
                          child: Text(
                            'Activate Device',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool isValidEmail(String email) {
    return RegExp(r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$").hasMatch(email);
  }

 bool isValidPhoneNumber(String phoneNumber) {
  return RegExp(r"^[0-9]{6,}$").hasMatch(phoneNumber);
}
}
