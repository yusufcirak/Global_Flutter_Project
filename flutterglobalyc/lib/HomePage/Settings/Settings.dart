import 'package:flutter/material.dart';
import 'package:flutterglobalyc/DatabaseHelper.dart';
import 'package:flutterglobalyc/TestMode/TestModeNawbar.dart';
import 'package:flutterglobalyc/Update/UpdateNawbar.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  DatabaseHelper dbHelper = DatabaseHelper();
  String pageContent = 'Loading...';

  @override
  void initState() {
    super.initState();
    _loadPageContent();
  }

  Future<void> _loadPageContent() async {
    String content = await dbHelper.getDeviceName();
    setState(() {
      pageContent = content;
    });
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
            child: Padding(
              padding: EdgeInsets.only(top: 125.0),
              child: Text(
                pageContent,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: 170.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpdateNawbar(),
                        ),
                      );
                    },
                    child: Text('Update Mode'),
                  ),
                  SizedBox(width: 16.0), // İstedğiniz kadar boşluk ekleyebilirsiniz
                      ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TestModeNawbar(),
                        ),
                      );
                    },
                    child: Text('Test Mode'),
                  ),
                ],
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: Text(
                '© 2023 Zemits California',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
            ),



          ),
        ],
      ),
    );
  }
}
  void main() {
    runApp(MaterialApp(
      home: Settings(),
    ));
  }

