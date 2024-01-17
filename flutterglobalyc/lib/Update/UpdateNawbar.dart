import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutterglobalyc/Update/SoftwareUpdate.dart';

import 'package:flutterglobalyc/HomePage/Nawbar.dart';

class UpdateNawbar extends StatefulWidget {
  @override
  _UpdateNawbarState createState() => _UpdateNawbarState();
}

class _UpdateNawbarState extends State<UpdateNawbar> {
  int _currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getAppBarTitle()), // Dinamik olarak başlık belirleme
        centerTitle: true,
        automaticallyImplyLeading: false, // Geri gitme düğmesini otomatik olarak eklemeyi devre dışı bırakma
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Nawbar()));
          },
        ),
      ),
      body: _buildPage(_currentIndex),
      bottomNavigationBar: CurvedNavigationBar(
        index: _currentIndex,
        backgroundColor: Colors.transparent,
        color: Colors.blue,
        buttonBackgroundColor: Colors.white,
        items: <Widget>[
         Image.asset('lib/images/Marketing.png', width: 30, height: 30),
        ],
        onTap: _onTabTapped,
      ),
    );
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return SoftwareUpdate();
      default:
        return SoftwareUpdate();
    }
  }

  String _getAppBarTitle() {
    switch (_currentIndex) {
      case 0:
        return 'Software Update Mode';
           default:
        return 'Unknown';
    }
  }
}


  void main() {
    runApp(MaterialApp(
      home: UpdateNawbar(),
    ));
  }
