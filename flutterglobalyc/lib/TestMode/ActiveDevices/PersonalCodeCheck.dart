import 'package:flutter/material.dart';
import 'package:flutterglobalyc/DatabaseHelper.dart';
import 'package:flutterglobalyc/HomePage/nawbar.dart';

class PersonalCodeCheck extends StatelessWidget {
  final TextEditingController _codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Active Devices'),
           centerTitle: true,// Set your app bar title here
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: 1280,
          height: 800,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Color(0xFFF6F9FF)),
          child: Stack(
            children: [
              Positioned(
                    left: 500,
                top: 50,
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
               left: 350,
              right: 350,
              top: 125,
                child: Container(
                  width: 520,
                  height: 575,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 520,
                          height: 575,
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
                            'Enter your personal Code',
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
                        top: 140,
                        child: Container(
                          width: 350,
                          height: 56,
                          child: TextField(
                            controller: _codeController,
                            keyboardType: TextInputType.number,
                            enabled: false,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xFFF6F9FF),
                              labelText: 'Enter Code',
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
                      _buildKeypad(context), // context parametresi eklendi
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

  Widget _buildKeypad(BuildContext context) {
    List<List<String>> keypadRows = [
      ['1', '2', '3'],
      ['4', '5', '6'],
      ['7', '8', '9'],
      ['Dell', '0', 'Enter'],
    ];

    double buttonSize = 80.0;
    double buttonSpacing = 10.0;

    return Positioned(
      left: 125,
      top: 210,
      child: Column(
        children: keypadRows.map((row) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: row.map((key) {
              return Container(
                width: buttonSize,
                height: buttonSize,
                margin: EdgeInsets.all(buttonSpacing / 2),
                child: ElevatedButton(
                  onPressed: () => _onKeyPressed(key, context),
                  child: Text(
                    key,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: const Color(0xFFF6F9FF),
                    padding: EdgeInsets.all(16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        }).toList(),
      ),
    );
  }

  void _onKeyPressed(String key, BuildContext context) {
  if (key == 'Dell') {
    if (_codeController.text.isNotEmpty) {
      _codeController.text =
          _codeController.text.substring(0, _codeController.text.length - 1);
    }
  } else if (key == 'Enter') {
    // Veritabanı kontrolü yapılacak
    _checkDatabase(context);
  } else {
    _codeController.text += key;
  }
}
void _checkDatabase(BuildContext context) async {
  String enteredCodeText = _codeController.text.trim();

  if (enteredCodeText.isEmpty) {
    _showErrorDialog(context, 'Please enter a code.');
    return;
  }

  // Girilen kod
  int? enteredCode = int.tryParse(enteredCodeText);

  if (enteredCode == null) {
    _showErrorDialog(context, 'Invalid code format. Please enter a valid code.');
    return;
  }

  // Veritabanındaki personal code kontrolü
  DatabaseHelper databaseHelper = DatabaseHelper();
  bool isCodeValid = await databaseHelper.checkPersonalCode(enteredCode);

  if (isCodeValid) {
    // Eşleşiyorsa başka sayfaya yönlendir
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Nawbar()), // İkinci sayfa widget'ını ekleyin
    );
  } else {
    // Eğer kod eşleşmiyorsa hata mesajı göster
    _showErrorDialog(context, 'Invalid code. Please try again.');
  }
}


void _showErrorDialog(BuildContext context, String errorMessage) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Error'),
        content: Text(errorMessage),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}
}
