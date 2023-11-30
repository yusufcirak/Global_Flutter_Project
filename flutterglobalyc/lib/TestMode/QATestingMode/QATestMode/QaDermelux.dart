import 'package:flutter/material.dart';
import 'package:serial_communication/serial_communication.dart';
import 'package:flutterglobalyc/DatabaseHelper.dart';
import 'package:flutterglobalyc/TestMode/ActiveDevices/ActiveDevicesPage.dart';
import 'package:flutterglobalyc/HomePage/Nawbar.dart';
void main() => runApp(MaterialApp(home: QaDermelux()));
class QaDermelux extends StatefulWidget {
  @override
  _QaDermeluxState createState() => _QaDermeluxState();
}

class _QaDermeluxState extends State<QaDermelux> {
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
  String  HydroWandStart = "HydroWandStart";
  String DeviceSerialNumber = "";
  String  HydroWandStop = "HydroWandStop";
  String  CoolingStart = "CoolingStart";
  String  CoolingStop = "CoolingStop";
  String  OxyStart = "OxyStart";
  String  OxyStop = "OxyStop";
  double  TempRead = 0.0;
  
  


void SelectDevicePort() async {
  SerialCommunication serialCommunication = SerialCommunication();

  // Kullanılabilir portları al
  List<String>? availablePorts = await serialCommunication.getAvailablePorts();

  if (availablePorts != null && availablePorts.isNotEmpty) {
    String? selectedPort = await selectESP32Port(availablePorts);

    if (selectedPort != null) {
      // // Open the selected port
      await serialCommunication.openPort(serialPort: selectedPort, baudRate: 115200);
      print("Port opened: $selectedPort");
    } else {
      print("ESP32 not found.");
    }
  } else {
    print("No serial ports found.");
  }
}

Future<String?> selectESP32Port(List<String> availablePorts) async {
  for (String port in availablePorts) {
      // Open port
    await serialCommunication.openPort(serialPort: port, baudRate: 115200);
// Send a test command and wait for the response
    String? response = await serialCommunication.sendCommand(message: "ESP32_TEST");


   // Check if the response contains "ESP32"
  if (response != null && response.contains("ESP32")) {
  // ESP32 found, handle accordingly
  return port; // Assuming this code is within a function that returns a String?
}


    // ESP32 değilse portu kapat
    await serialCommunication.closePort();
  }

  return null; // ESP32 bulunamadı
}


// Widget oluşturulduğunda çalışır. Başlangıçta cihaz portunu seçer.
  @override
  void initState() {
    super.initState();
    SelectDevicePort();
    deviceCommand();
  }


//Widget kaldırıldığında çalışır. Seri iletişim objesini temizler.
  @override
  void dispose() {
    serialCommunication.destroy();
    super.dispose();
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 130.0),
                  child: Text(
                    'QA Testing Mode',
                    style: TextStyle(fontSize: 30, color: Colors.black),
                  ),
                ),
                SizedBox(height: 10.0),
                Padding(
                  padding: EdgeInsets.only(top: 30.0),
                  child: Text(
                    'Dermeluxx',
                    style: TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 40.0),
                Row(

                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 0.0,height: 200.0),
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
                              fixedSize: Size(200, 75),
                            ),
                          ),
                          SizedBox(height: 16), // İhtiyaca göre boşluk ekleyebilirsiniz
                          Text(
                            'Hydro Wand',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ],
                      ),
                    SizedBox(width: 250.0,),
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
                              fixedSize: Size(200, 75),
                            ),
                          ),
                          SizedBox(height: 16), // İhtiyaca göre boşluk ekleyebilirsiniz
                          Text(
                            'Cooling',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ],
                      ),

                  ],
                ),

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
            fixedSize: Size(200, 75),
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
        SizedBox(width: 230.0),
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
                backgroundColor: Colors.green, // Button rengi
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0), // Kare olması için
                ),
                fixedSize: Size(50, 50), // Button boyutu
              ),
            ),
          ],
        ),
        SizedBox(width: 10.0), // Aralık ekleyebilirsiniz
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Sıcaklık değeri
            Text(
              '$simpleIntInput °C',
              style: TextStyle(fontSize: 24.0), // Text boyutu
            ),
            // Bilgilendirme metni
            Text(
              'Cooling Setting',
              style: TextStyle(fontSize: 12.0, color: Colors.grey),
            ),
          ],
        ),
        SizedBox(width: 10.0), // Aralık ekleyebilirsiniz
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // "-" button
            ElevatedButton(
              onPressed: () {
                setState(() {
                  simpleIntInput--;
                });
              },
              child: Text('-', style: TextStyle(fontSize: 24.0)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Button rengi
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0), // Kare olması için
                ),
                fixedSize: Size(50, 50), // Button boyutu
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
        padding: EdgeInsets.only(top: 100.0),
        child: Text(
           '$TempRead °C',
          style: TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),
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
          'Temperature',
          style: TextStyle(fontSize: 30, color: Colors.black),
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
          style: TextStyle(fontSize: 30, color: Colors.black),
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
        padding: EdgeInsets.only(top: 100.0),
        child: Text(
          'Testing Report',
          style: TextStyle(fontSize: 30, color: Colors.black),
        ),
      ),
    ),

  ],
  ),  


          Container(
            width: 550.0, // Row'un genişliği
            height: 50.0, // Row'un yüksekliği
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Text(
                      'Power Check:',
                      style: TextStyle(fontSize: 24, color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(width: 250.0),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Text(
                      powerCheckResult ? 'Ok' : 'Error',
                      style: TextStyle(
                        fontSize: 24,
                        color: powerCheckResult ? Colors.green : Colors.red,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

  Container(
            width: 550.0, // Row'un genişliği
            height: 50.0, // Row'un yüksekliği
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Text(
                      'Temperature Check:',
                      style: TextStyle(fontSize: 24, color: Colors.black),
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
                        fontSize: 24,
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
        padding: EdgeInsets.only(top: 30.0),
        child: ElevatedButton(
          onPressed: () async {
            await DatabaseHelper().setManufacturerModeStatus(true);
           
            checkDeviceStatus();
          },
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(Size(150, 80)), // Genişlik ve yükseklik değerlerini ayarlayın
          ),
          child: Text('QA Testing Mode Completed'),
        ),
      ),
    ),
  ],
)



             
              ],
            ),
          ),
        ],
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

  void StopSerial () async  {
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


void deviceCommand(){

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
      // Başlığı çıkart ve geri kalanı al
      String temperatureValue = receivedData.substring(8);
      double temperatureDoubleValue = double.parse(temperatureValue);
      print("Temp: $temperatureDoubleValue");
      setState(() {
        TempRead = temperatureDoubleValue;
      });
    }

    if (receivedData.startsWith("SerialNumber:")){
      String SerialNumber = receivedData.substring(13);
      print("SerialNumber: $SerialNumber");
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
    home: QaDermelux(),
  ));
}

}