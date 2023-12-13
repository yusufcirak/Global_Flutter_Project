import 'package:flutter/material.dart';
import 'package:flutterglobalyc/DatabaseHelper.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutterglobalyc/TestMode/ActiveDevices/ActiveDevicesPage.dart';
import 'package:flutterglobalyc/HomePage/Nawbar.dart';
import 'package:flutter/services.dart';

void main() => runApp(MaterialApp(home: MmDermelux()));
class MmDermelux extends StatefulWidget {
 

 
  @override
  _MmDermeluxState createState() => _MmDermeluxState();
}


class _MmDermeluxState extends State<MmDermelux> {
String portName = "";
  int baudRate = 115200;
  
static const platform = MethodChannel('com.ycirak.flutterglobalyc/serial');
   void setSerialPortSettings() async {
    try {
      final result = await platform.invokeMethod('setSerialPortSettings', {
        'portName': portName,
        'baudRate': baudRate,
      });
      print(result);
    } catch (e) {
      print(e);
    }
  }


  bool isHydroWand = false;
  bool isCooling = false;
  bool isOxy= false;
  String logData = "";
  String receivedData = "";
  int simpleIntInput = 0;
  double receiveTempData= 0.0; 
  bool powerCheckResult = true; 
  bool temperatureCheckResult = false; 
  String  HydroWandStart = "1";
  String DeviceSerialNumber = "";
  String  HydroWandStop = "2";
  String  CoolingStart = "3";
  String  CoolingStop = "4";
  String  OxyStart = "5";
  String  OxyStop = "6";
  double  TempRead = 0.0;
  
  
Future<void> sendSerialData(String data) async {
  try {
    final String result = await platform.invokeMethod('sendData', {'data': data});
    setState(() {
      logData = result; // Log verilerini güncelle
    });
  } catch (e) {
    print(e);
  }
}

Future<void> receiveSerialData() async {
  try {
    final String result = await platform.invokeMethod('receiveSerialData');
    setState(() {
      receivedData = result; 
    });
  } catch (e) {
    print(e);
  }
}

  
@override
  void initState() {
    super.initState();
  }

  void dispose() {

    super.dispose();

  }
  Future<void> requestPermissions() async {
  Map<Permission, PermissionStatus> permissions = await [
    Permission.storage,
 
  ].request();
 Permission.storage.onDeniedCallback;
  print('Storage Permission: ${permissions[Permission.storage]}');
 
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: Image.asset(
                    'lib/images/zlogo.png',
                    width: 100,
                    height: 100,
                  ),
                ),
              ),
              SizedBox(height: 1.0),
              Text(
                'Manufacturing Mode',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              SizedBox(height: 1.0),
              Text(
                'Dermeluxx',
                style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5.0),
                    Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isHydroWand = !isHydroWand;
                                buttonStatus();

                          });
                        },
                        child: Text(isHydroWand ? 'ON' : 'OFF'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isHydroWand ? Colors.green : Colors.red,
                          fixedSize: Size(150, 50),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Hydro Wand',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(width: 250.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isCooling = !isCooling;
                                buttonStatus();

                          });
                        },
                        child: Text(isCooling ? 'ON' : 'OFF'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isCooling ? Colors.green : Colors.red,
                             fixedSize: Size(150, 50),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Cooling',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 20.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isOxy = !isOxy;
                                buttonStatus();

                          });
                        },
                        child: Text(isOxy ? 'ON' : 'OFF'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isOxy ? Colors.green : Colors.red,
                             fixedSize: Size(150, 50),
                        ),
                      ),
                      Text(
                        'Oxy Function',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(width: 15.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 175.0),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                simpleIntInput++;
                              });
                            },
                            child: Text('+', style: TextStyle(fontSize: 24.0)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              fixedSize: Size(50, 50),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 10.0),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '$simpleIntInput °C',
                            style: TextStyle(fontSize: 24.0),
                          ),
                          Text(
                            'Cooling Setting',
                            style: TextStyle(fontSize: 12.0, color: Colors.grey),
                          ),
                        ],
                      ),
                      SizedBox(width: 10.0),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                simpleIntInput--;
                              });
                            },
                            child: Text('-', style: TextStyle(fontSize: 24.0)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              fixedSize: Size(50, 50),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Text(
                        '$TempRead °C',
                        style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.only(top: 5.0),
                      child: Text(
                        'Temperature',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Text(
                        'Device Serial Number: $DeviceSerialNumber',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Text(
                        'Testing Report',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                width: 550.0,
                height: 50.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: Text(
                          'Power Check:',
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(width: 250.0),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: Text(
                          powerCheckResult ? 'Ok' : 'Error',
                          style: TextStyle(
                            fontSize: 20,
                            color: powerCheckResult ? Colors.green : Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 550.0,
                height: 50.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Text(
                          'Temperature Check:',
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(width: 183.0),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Text(
                          temperatureCheckResult ? 'Ok' : 'Error',
                          style: TextStyle(
                            fontSize: 20,
                            color: temperatureCheckResult ? Colors.green : Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          await DatabaseHelper().setManufacturerModeStatus(true);
                          checkDeviceStatus();
                        },
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(Size(100, 60)),
                        ),
                        child: Text('Manufacturer Mode Completed'),
                      ),
                    ),
                  ),
                ],
              ),  




             
              ],
            ),
          ),
       
      ),
    );

    
  }
  
    void updatePowerCheckResult(bool result) {
    setState(() {
      powerCheckResult = result;
    });
  }

  void updateTemperatureCheckResult(bool result) {
    setState(() {
      temperatureCheckResult = result;
    });
  }


void buttonStatus(){
  if(isHydroWand == true){
    sendSerialData(HydroWandStart);
  }
  else{
    sendSerialData(HydroWandStop);
  }
  if(isCooling == true){
    sendSerialData(CoolingStart);
  }
  else{
    sendSerialData(CoolingStop);
  }
  if(isOxy == true){
    sendSerialData(OxyStart);
  }
  else{
    sendSerialData(OxyStop);
  }
}
  void updateTempRead(double result) {
    setState(() {
      TempRead = result;
    });

}
  
  Future<void> checkDeviceStatus() async {
    bool isDeviceActive = await dbHelper.checkDeviceStatus();

    if (isDeviceActive) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Nawbar(),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ActiveDevicesPage(),
        ),
      );
    }
  }

  void main() {
    runApp(MaterialApp(
      home: MmDermelux(),
    ));
  }

 
}