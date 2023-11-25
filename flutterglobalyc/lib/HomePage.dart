import 'package:flutter/material.dart';
import 'package:flutterglobalyc/DatabaseHelper.dart';
import 'package:flutterglobalyc/HomePage/Nawbar.dart';

import 'package:flutterglobalyc/ActiveDevices/ActiveDevices.dart';
void main() => runApp(MaterialApp(home: HomePage()));

class HomePage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomLogoAnimation(),
      ),
    );
  }
}

class CustomLogoAnimation extends StatefulWidget {
  @override
  _CustomLogoAnimationState createState() => _CustomLogoAnimationState();
}

class _CustomLogoAnimationState extends State<CustomLogoAnimation>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);

  @override
  void initState() {
    super.initState();
    // Bekleme süresi sonunda yönlendirme yapılacak.
    Future.delayed(Duration(seconds: 3), () {
      checkDeviceStatusAndRedirect();
    });
  }


 Future<void> checkDeviceStatusAndRedirect() async {
  bool isDeviceActive = await dbHelper.checkDeviceStatus();

  if (isDeviceActive) {
    // Cihaz aktifse Nawbar'e yönlendir
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Nawbar(),
      ),
    );
  } else {
    // Cihaz aktif değilse başka bir sayfaya yönlendir
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ActiveDevicesPage(),
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _controller.value,
          child: Image.asset(
            'lib/images/zlogo.png',
            width: 400,
            height: 400,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

}



class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final dbHelper = DatabaseHelper();
  bool deviceStatus = false; // Başlangıçta false olarak ayarla
  List<Map<String, dynamic>> allData = [];

  @override
  void initState() {
    super.initState();
    displayData(); // Verileri çağır
  }
@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Center(
          child: deviceStatus
              ? Text('Device Status: True')
              : Text('Device Status: False'),
        ),
        SizedBox(height: 16),
        Text('All Data:'),
        Expanded(
          child: ListView.builder(
            itemCount: allData.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('Name: ${allData[index]['name']}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Email: ${allData[index]['email']}'),
                    Text('Device Name: ${allData[index]['devicename']}'),
                    Text('Phone Number: ${allData[index]['phonenumber']}'),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}

  Future<void> displayData() async {
    final data = await dbHelper.getAllData();
    if (data.isNotEmpty) {
      // Veritabanından alınan ilk verinin "devicestatus" alanını kontrol et
      if (data[0]['devicestatus'] == 1) {
        setState(() {
          deviceStatus = true;
        });
      } else {
        setState(() {
          deviceStatus = false;
        });
      }

      // Tüm verileri listeye ekle
      setState(() {
        allData = data;
      });
    }
  }
}

