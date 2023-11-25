import 'package:flutter/material.dart';
import 'package:flutterglobalyc/DatabaseHelper.dart';
import 'package:flutterglobalyc/HomePage/Treatment/Function1Steps/Function1Page.dart';
import 'package:flutterglobalyc/HomePage/Treatment/Function2Steps/Function2Page.dart';
import 'package:flutterglobalyc/HomePage/Treatment/Function3Steps/Function3Page.dart';
import 'package:flutterglobalyc/HomePage/Treatment/Function4Steps/Function4Page.dart';

class Treatment extends StatefulWidget {
  @override
  _TreatmentState createState() => _TreatmentState();
}

class _TreatmentState extends State<Treatment> {
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
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 16),
                Row(

                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    
                    InkWell(
                    onTap: () {
                          Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Function1Page(),
                          ),
                        );
                   },
                    child: Column(
                      children: <Widget>[
                        Image.asset(
                          'lib/images/st3.png',
                          width: 300,
                          height: 300,
                        ),
                        Text('Function 1'),
                      ],
                    ),
                  ),
                    SizedBox(width: 16),
                 InkWell(
                    onTap: () {
                          Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Function2Page(),
                          ),
                        );
                   },
                    child: Column(
                      children: <Widget>[
                        Image.asset(
                          'lib/images/st5.png',
                          width: 300,
                          height: 300,
                        ),
                        Text('Function 2'),
                      ],
                    ),
                  ),
                    
                  ],
                ),
                Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: <Widget>[
 InkWell(
                    onTap: () {
                          Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Function3Page(),
                          ),
                        );
                   },
                    child: Column(
                      children: <Widget>[
                        Image.asset(
                          'lib/images/st5.png',
                          width: 300,
                          height: 300,
                        ),
                        Text('Function 3'),
                      ],
                    ),
                  ),
    SizedBox(width: 16),
     InkWell(
                    onTap: () {
                          Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Function4Page(),
                          ),
                        );
                   },
                    child: Column(
                      children: <Widget>[
                        Image.asset(
                          'lib/images/st3.png',
                          width: 300,
                          height: 300,
                        ),
                        Text('Function 4'),
                      ],
                    ),
                  ),
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
