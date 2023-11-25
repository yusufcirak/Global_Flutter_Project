
import 'package:flutter/material.dart';

class MmCoolRestore extends StatefulWidget {
  @override
  _MmCoolRestoreState createState() => _MmCoolRestoreState();
}

class _MmCoolRestoreState extends State<MmCoolRestore> {
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
                    'Manufacturing Mode',
                    style: TextStyle(fontSize: 30, color: Colors.black),
                  ),
                ),
                SizedBox(height: 10.0),
                
               

                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
             
               SizedBox(width: 20.0),
                 
     
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
    home: MmCoolRestore(),
  ));
}
