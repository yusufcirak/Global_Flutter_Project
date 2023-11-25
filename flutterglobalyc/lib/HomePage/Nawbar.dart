import 'package:flutter/material.dart';
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
      bottomNavigationBar: BottomNavigationBar(
         backgroundColor: Colors.white, // Burada arka plan rengini beyaz olarak ayarlayabilirsiniz
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        selectedItemColor: Colors.blue, // Seçili olan yazı rengi
        unselectedItemColor: Colors.grey, // Seçili olmayan yazı rengi
         selectedIconTheme: IconThemeData(color: Colors.blue),
        unselectedIconTheme: IconThemeData(color: Colors.grey),
        
        type: BottomNavigationBarType.fixed, // Tüm yazıların görünmesini sağlar
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset('lib/images/treatment.png'),
            label: 'Treatment',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('lib/images/educations.png'),
            label: 'Educations',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('lib/images/Marketing.png'),
            label: 'Marketing',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('lib/images/calendar.png'),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('lib/images/test.png'),
            label: 'Settings',
          ),
        ],
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
