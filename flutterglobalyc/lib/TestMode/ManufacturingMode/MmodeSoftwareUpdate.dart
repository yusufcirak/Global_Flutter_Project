import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; 
import 'package:flutterglobalyc/TestMode/ManufacturingMode/DeviceTestMode/MmDermelux.dart';
import 'package:flutterglobalyc/DatabaseHelperUpdate.dart';
void main() {
  runApp(MaterialApp(
    home: MmodeSoftwareUpdate(),
  ));
}

class MmodeSoftwareUpdate extends StatefulWidget {
  @override
  _MmodeSoftwareUpdateState createState() => _MmodeSoftwareUpdateState();
}

class _MmodeSoftwareUpdateState extends State<MmodeSoftwareUpdate> {
  String currentZemitsOsVersion = '1.0.0';
  String newZemitsOsVersion = '';
  bool isCheckVersionVisible = true;
String? filepath;
bool isnextbutton=false;
    var dbHelper = DatabaseHelperUpdate();
  bool isZemitsOsUpdateVisible = false;
  String updateStatusMessage = '';
 bool isDownloadings = false;
 bool isZemitsOsUpdateVisibleText=false;
  bool isUpdateing=false;
 bool isUpdate=false;
  Future<void> checkVersion() async {

    String? currentVersion = await getCurrentVersion();

    setState(() {
      if (currentVersion != null) {
        isCheckVersionVisible = false;
        newZemitsOsVersion = currentVersion;

        if (currentVersion != currentZemitsOsVersion) {
          isZemitsOsUpdateVisible = true;
          isZemitsOsUpdateVisibleText=true;
          updateStatusMessage = 'Updates Available';
        } else {
          updateStatusMessage = 'Version Current';
        }
      } else {
     
        updateStatusMessage = 'Error fetching version';
      }
    });
  }
  
Future<String?> getCurrentVersion() async {
  var url = Uri.parse('https://yusufcirak.com.tr/zemitsapi/api.php');
  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
         String responseBody = response.body;
      final List<dynamic> jsonData = json.decode(responseBody);
      print(jsonData);

      return jsonData.isNotEmpty ? jsonData[0]['software_version'] : null;
    } else {
      print('HTTP Error: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('Error: $e');
    return null;
  }
}


Future<void> downloadUpdate() async {

   setState(() {
    isDownloadings = true; 
  });

  var url = Uri.parse('https://yusufcirak.com.tr/zemitsapi/api.php'); // Sunucudan verileri çekeceğiniz URL'yi belirtin

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      String responseBody = response.body;
      final List<dynamic> jsonData = json.decode(responseBody);

      if (jsonData.isNotEmpty) {
        String filePath = jsonData[0]['file_path'];
        String fileName = filePath.split('/').last;
        String downloadUrl = 'https://yusufcirak.com.tr/zemitsapi/$fileName';

        var fileResponse = await http.get(Uri.parse(downloadUrl));

        if (fileResponse.statusCode == 200) {
          String? dirPath = getDownloadsDirectory();
          final File file = File('$dirPath/$fileName');

         
          if (!await Directory(dirPath).exists()) {
            await Directory(dirPath).create(recursive: true);
          }

          await file.writeAsBytes(fileResponse.bodyBytes);

          if (await file.exists()) {
            print('The file was successfully downloaded and stored on the device: ${file.path}');
             setState(() {
                isDownloadings = false; 
                isUpdate=true;
                isZemitsOsUpdateVisible=false;
              });
          } else {
            print('There was an error downloading the file.');
          }
                } else {
          print('There was an error downloading the file: ${fileResponse.statusCode}');
        }
      }
    } else {
      print('An error occurred while retrieving data: ${response.statusCode}');
    }
  } catch (e) {
    print('Error:$e');
  }
}

String getDownloadsDirectory() {
  if (Platform.isAndroid) {
    return Directory('/storage/emulated/0/Download').path;
  }
  return ''; 
}

String buildDownloadUrl(String fileName) {
  String dirPath = getDownloadsDirectory();
  if (dirPath.isNotEmpty) {
    return '$dirPath/$fileName';
  }
  return ''; 
}



 Future<void> installApk(String apkFilePath) async {
  try {
      isUpdateing=true;
    final result = await Process.run('adb', ['install', '-r', apkFilePath]);

    if (result.exitCode == 0) {
      print('APK file installed successfully.');
      isnextbutton=true;
      isUpdate=false;  
       isUpdateing=false;
    
    } else {
      print('There was an error installing the APK file:\n${result.stdout}\n${result.stderr}');
        isUpdateing=false;
    }
  } catch (e) {
    print('Error: $e');
  }
}

Future<void> _sendWifiInfoToSerialPort(String ssid, String password) async {
  
  serialPortManager.sendData(ssid+";"+password+";");
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
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 150.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        'ZemitsOs Current\n\t\t\tVersion: $currentZemitsOsVersion',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                      if (isZemitsOsUpdateVisibleText)
                        Text(
                          'New: $newZemitsOsVersion',
                          style: TextStyle(fontSize: 20, color: Colors.red),
                        ),
                      SizedBox(height: 50),
                      Visibility(
                        visible: isZemitsOsUpdateVisible,
                        child: ElevatedButton(
                          onPressed: () {
                            downloadUpdate(); 
                          },
                          style: ElevatedButton.styleFrom(
                            side: BorderSide(width: 2.0, color: Colors.blue),
                            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                          ),
                          child: Text('Download New Update', style: TextStyle(fontSize: 18, color: Colors.blue)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 50.0),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: isCheckVersionVisible,
                      child: ElevatedButton(
                        onPressed: checkVersion,
                        style: ElevatedButton.styleFrom(
                          side: BorderSide(width: 2.0, color: Colors.blue),
                          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                        ),
                        child: Text('Check Version', style: TextStyle(fontSize: 18, color: Colors.blue)),
                      ),
                    ),
                    Visibility(
                      visible: isDownloadings,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Downloading Update, please wait...",
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                       Visibility(
                      visible: isUpdateing,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Uploading Update, please wait...",
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: isUpdate,
                      child: ElevatedButton(
                        onPressed: () {
                          installApk(buildDownloadUrl('zemits.'+'$newZemitsOsVersion'+'.apk')); 
                           serialPortManager.sendData("update;");
                        },
                        style: ElevatedButton.styleFrom(
                          side: BorderSide(width: 2.0, color: Colors.blue),
                          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                        ),
                        child: Text('ZemitsOs Update', style: TextStyle(fontSize: 18, color: Colors.blue)),
                      ),
                    ),
                    Visibility(
                            visible: isnextbutton,
                            child: ElevatedButton(
                              onPressed: () async {  
                                var dbHelper = DatabaseHelperUpdate(); 
                                Map<String, String> wifiInfo = await dbHelper.getWifiInfo(); 
                                print('WiFi SSID: ${wifiInfo['wifiSsid']}, WiFi Password: ${wifiInfo['wifiPass']}');
                                        String ssid = wifiInfo['wifiSsid'] ?? 'unknown';  
                                        String password = wifiInfo['wifiPass'] ?? 'unknown';

                                 await _sendWifiInfoToSerialPort(ssid, password);


                                Navigator.push(context, MaterialPageRoute(builder: (context) => MmDermelux()));
                              },
                              style: ElevatedButton.styleFrom(
                                side: BorderSide(width: 2.0, color: Colors.blue),
                                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                              ),
                              child: Text('Next Step', style: TextStyle(fontSize: 18, color: Colors.blue)),
                            ),
                          ),

                  ],
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      '© 2023 Zemits California',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
}





