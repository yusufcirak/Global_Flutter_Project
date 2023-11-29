import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutterglobalyc/HomePage/Calendar/Calendar.dart';
import 'package:flutterglobalyc/HomePage/Treatment/Treatment.dart';
import 'package:flutterglobalyc/HomePage/Educations/Educations.dart';
import 'package:flutterglobalyc/HomePage/Marketing/Marketing.dart';
import 'package:flutterglobalyc/HomePage/Settings/Settings.dart';

class Nawbar extends StatefulWidget {
  @override
  _NawbarState createState() => _NawbarState();
}

class _NawbarState extends State<Nawbar> {
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
        //title center
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: _buildPage(_currentIndex),
      bottomNavigationBar: CurvedNavigationBar(
        index: _currentIndex,
        backgroundColor: Colors.transparent,
        color: Colors.blue, // Seçili olan öğe rengi
        buttonBackgroundColor: Colors.white, // Navigasyon çubuğunun arka plan rengi
        items: <Widget>[
          Image.asset('lib/images/treatment.png', width: 30, height: 30),
          Image.asset('lib/images/educations.png', width: 30, height: 30),
          Image.asset('lib/images/Marketing.png', width: 30, height: 30),
          Image.asset('lib/images/calendar.png', width: 30, height: 30),
          Image.asset('lib/images/test.png', width: 30, height: 30),
        ],
        onTap: _onTabTapped,
      ),
    );
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return Treatment();
      case 1:
        return Educations();
      case 2:
        return Marketing();
      case 3:
        return Calendar();
      case 4:
        return Settings();
      default:
        return Treatment();
    }
  }

  String _getAppBarTitle() {
    switch (_currentIndex) {
      case 0:
        return 'Treatment';
      case 1:
        return 'Educations';
      case 2:
        return 'Marketing';
      case 3:
        return 'Calendar';
      case 4:
        return 'Settings';
      default:
        return 'Unknown';
    }
  }
}
