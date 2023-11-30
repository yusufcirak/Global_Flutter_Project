import 'package:flutter/material.dart';
import 'package:flutterglobalyc/DatabaseHelper.dart';
import 'package:flutterglobalyc/TestMode/ActiveDevices/PersonalCodeCheck.dart';

final dbHelper = DatabaseHelper();

class PersonalCodePage extends StatelessWidget {
  final TextEditingController _codeController1 = TextEditingController();
  final TextEditingController _codeController2 = TextEditingController();

  Future<void> saveCode(int code) async {
    final Map<String, dynamic> data = {'personalcode': code};
    await dbHelper.insertData(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Active Devices'),
           centerTitle: true, 
      ),
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
                        top: -100,
                        child: SizedBox(
                          width: 392,
                          child: Image.asset(
                            'lib/images/key.png',
                            width: 400,
                            height: 400,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 64,
                        top: 150,
                        child: SizedBox(
                          width: 392,
                          child: Text(
                            'Create your personal Code for security access',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 32,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              height: 1.2,
                              letterSpacing: 0.5,
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
                            controller: _codeController1,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xFFF6F9FF),
                              labelText: 'Re-Enter Code',
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
                        top: 256,
                        child: Container(
                          width: 360,
                          height: 56,
                          child: TextField(
                            controller: _codeController2,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xFFF6F9FF),
                              labelText: 'Enter Code',
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
                        top: 392,
                        child: SizedBox(
                          width: 360,
                          height: 52,
                          child: TextButton(
                            onPressed: () async {
                              String code1 = _codeController1.text;
                              String code2 = _codeController2.text;

                              if (code1.isNotEmpty && code1 == code2) {
                                // İki kod eşit, veritabanına kaydet
                                await saveCode(int.parse(code1));

                                // Yeni sayfaya yönlendirme
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PersonalCodeCheck(),
                                  ),
                                );
                              } else {
                                // Hata durumunda kullanıcıyı bilgilendir
                                // Örneğin:
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text('Error'),
                                    content: Text('Codes do not match or empty.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('OK'),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Color(0xFF1559C4)),
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                            ),
                            child: Text(
                              'Create',
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
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: PersonalCodePage(),
  ));
}
