import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutterglobalyc/TestMode/ManufacturingMode/MmodeLogin.dart';
import 'package:flutterglobalyc/TestMode/QATestingMode/QaModeLogin.dart';
import 'package:flutterglobalyc/TestMode/ActiveDevices/ActiveDevicesPage.dart';
import 'package:flutterglobalyc/HomePage/Nawbar.dart';

class TestModeNawbar extends StatefulWidget {
  @override
  _TestModeNawbarState createState() => _TestModeNawbarState();
}

class _TestModeNawbarState extends State<TestModeNawbar> {
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
          Image.asset('lib/images/treatment.png', width: 30, height: 30),
          Image.asset('lib/images/educations.png', width: 30, height: 30),
          Image.asset('lib/images/Marketing.png', width: 30, height: 30),
        ],
        onTap: _onTabTapped,
      ),
    );
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return MmodeLogin();
      case 1:
        return ActiveDevicesPage();
      case 2:
        return QaModeLogin();
      default:
        return MmodeLogin();
    }
  }

  String _getAppBarTitle() {
    switch (_currentIndex) {
      case 0:
        return 'Manufacturing Mode';
      case 1:
        return 'Active Devices';
      case 2:
        return 'QA Testing Mode';
      default:
        return 'Unknown';
    }
  }
}
