import 'package:flutter/material.dart';
import 'package:serial_communication/serial_communication.dart';
import 'package:flutterglobalyc/DatabaseHelper.dart';
import 'package:flutterglobalyc/TestMode/ActiveDevices/ActiveDevicesPage.dart';
import 'package:flutterglobalyc/HomePage/Nawbar.dart';
void main() => runApp(MaterialApp(home: MmDermelux()));
class MmDermelux extends StatefulWidget {
  @override
  _MmDermeluxState createState() => _MmDermeluxState();
}

class _MmDermeluxState extends State<MmDermelux> {
SerialCommunication serialCommunication = SerialCommunication();
  bool isHydroWand = false;
  bool isCooling = false;
  bool isOxy= false;
  String logData = "";
  String receivedData = "";
  int simpleIntInput = 0;
  double receiveTempData= 0.0; 
  bool powerCheckResult = true; // İlk test raporu, başlangıçta true
  bool temperatureCheckResult = false; // İkinci test raporu, başlangıçta false
  String  HydroWandStart = "1";
  String DeviceSerialNumber = "";
  String  HydroWandStop = "2";
  String  CoolingStart = "3";
  String  CoolingStop = "4";
  String  OxyStart = "5";
  String  OxyStop = "6";
  double  TempRead = 0.0;
  
  
 List<String> availablePorts = [];
  String? selectedPort;
//D/SerialPort(21207): Found new device: /dev/ttyS7
//D/SerialPort(21207): Found new device: /dev/ttyS0
//D/SerialPort(21207): Found new device: /dev/ttyS2
///SerialPort(21207): Found new device: /dev/ttyS1
List<String>? serialList = [];

 void updateSelectedPort(String? port) {
    setState(() {
      selectedPort = "/dev/ttyS1";
    });
  }
void _updateConnectionStatus(SerialResponse? result) async {
    setState(() {
      logData = result!.logChannel ?? "";
      receivedData = result.readChannel ?? "";
    });
  }

  getSerialList() async {
    serialList = await serialCommunication.getAvailablePorts();
  }

  void initState() {
 

    print("send");
    print(selectedPort);
    super.initState();
    getAvailablePorts();
    deviceCommand();

       serialCommunication.startSerial().listen(_updateConnectionStatus);
    getSerialList();
//print the send command metods response
serialCommunication.startSerial().listen((SerialResponse result) {
      updateConnectionStatus(result);
    });
      var x = serialCommunication.sendCommand(message: "0001");
        x.then((value) => print("hata2")).catchError((error) => null);
     print(x.whenComplete(() => print("success")));

  }

  void dispose() {
    serialCommunication.destroy();
    super.dispose();
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
       Center(
  child: Container(
    width: 200.0, 
    child: DropdownButtonFormField(
      value: selectedPort,
      items: availablePorts
          .map((port) => DropdownMenuItem(
                child: Text(port),
                value: port,
              ))
          .toList(),
      onChanged: updateSelectedPort, 
      decoration: InputDecoration(
        labelText: 'Select Serial Port',
      ),
    ),
  ),
),



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

  void StartSerial() async {
    await serialCommunication.startSerial();
  }

  void StopSerial() async {
    await serialCommunication.closePort();
  }

  void sendDataToSerial() async {
    await serialCommunication.sendCommand(message: "Hello, ESP32!");
  }

  void updateConnectionStatus(SerialResponse? result) async {
    setState(() {
      logData = result!.logChannel ?? "";
      receivedData = result.readChannel ?? "";
    });
  }

  void deviceCommand() {
    print(receivedData);
if (isHydroWand) {
  serialCommunication.sendCommand(message: HydroWandStart);
} else {
  serialCommunication.sendCommand(message: HydroWandStop);
} if (isCooling) {
  serialCommunication.sendCommand(message: CoolingStart);
} else {
  serialCommunication.sendCommand(message: CoolingStop);
} if (isOxy) {
  serialCommunication.sendCommand(message: OxyStart);
} else {
  serialCommunication.sendCommand(message: OxyStop); 
}

    serialCommunication.sendCommand(message: "TargetTemp:" + simpleIntInput.toString());

    if (receivedData.startsWith("Temp:")) {
      String temperatureValue = receivedData.substring(5);
      double temperatureDoubleValue = double.parse(temperatureValue);
      setState(() {
        TempRead = temperatureDoubleValue;
      });
    }

    if (receivedData.startsWith("SerialNumber:")) {
      String SerialNumber = receivedData.substring(13);
      setState(() {
        DeviceSerialNumber = SerialNumber;
      });
    }
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

  void getAvailablePorts() async {
    List<String>? ports = await serialCommunication.getAvailablePorts();
    if (ports != null && ports.isNotEmpty) {
      setState(() {
        availablePorts = ports;
        selectedPort = ports[0];
      });
    }
  }
}