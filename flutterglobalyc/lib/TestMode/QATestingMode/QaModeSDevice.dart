import 'package:flutter/material.dart';
import 'package:flutterglobalyc/TestMode/QATestingMode/QATestMode/QaDermelux.dart';
import 'package:flutterglobalyc/TestMode/QATestingMode/QATestMode/QaHydroVerstand.dart';
import 'package:flutterglobalyc/TestMode/QATestingMode/QATestMode/QaVerstandHD.dart';
import 'package:flutterglobalyc/TestMode/QATestingMode/QATestMode/QaCoolRestore.dart';
class QaModeSDevice extends StatefulWidget {
  @override
  _QaModeSDeviceState createState() => _QaModeSDeviceState();
}

class _QaModeSDeviceState extends State<QaModeSDevice> {
  String _selectedDevice = ""; // Seçilen cihaz modeli
  List<String> deviceList = ["DermeLuxx", "HydroVerstand","Verstand HD","CoolRestore"];

  @override
  void initState() {
    super.initState();
    // deviceList içindeki tekrarlayan öğeleri kaldır
    deviceList = deviceList.toSet().toList();

    // _selectedDevice'ı default olarak ilk değerle ayarla (opsiyonel)
    if (deviceList.isNotEmpty) {
      _selectedDevice = deviceList.first;
    }
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
                SizedBox(height: 50.0),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 130.0),
                      child: Text(
                        'Choose Device Model:',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ),
                  ],
                ),

                Row(
                  
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 150.0),
                    DropdownMenuExample(
                      initialSelection: _selectedDevice,
                      onSelected: (String value) {
                        setState(() {
                          _selectedDevice = value;
                        });
                      },
                      dropdownMenuEntries: deviceList
                          .map<DropdownMenuEntry<String>>(
                            (String value) => DropdownMenuEntry<String>(
                              value: value,
                              label: value,
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                      
                        print("Selected Device: $_selectedDevice");
                        
                        if (_selectedDevice == "DermeLuxx") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QaDermelux(),
                            ),
                          );
                        } else if (_selectedDevice == "HydroVerstand") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QaHydroVerstand(),
                            ),
                          );
                        } else if (_selectedDevice == "Verstand HD") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QaVerstandHD(),
                            ),
                          );
                        } else if (_selectedDevice == "CoolRestore") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QaCoolRestore(),
                            ),
                          );
                        }
                     
                  
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(width: 2.0, color: Colors.blue),
                        padding: EdgeInsets.symmetric(
                            vertical: 15, horizontal: 30),
                      ),
                      child: Text(
                        'Start',
                        style: TextStyle(fontSize: 18, color: Colors.blue),
                      ),
                    ),
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

class DropdownMenuExample extends StatefulWidget {
  const DropdownMenuExample({
    Key? key,
    required this.initialSelection,
    required this.onSelected,
    required this.dropdownMenuEntries,
  }) : super(key: key);

  final String initialSelection;
  final ValueChanged<String> onSelected;
  final List<DropdownMenuEntry<String>> dropdownMenuEntries;

  @override
  _DropdownMenuExampleState createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  late String _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialSelection;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      initialSelection: _selectedValue,
      onSelected: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          _selectedValue = value!;
          widget.onSelected(value);
        });
      },
      dropdownMenuEntries: widget.dropdownMenuEntries,
    );
  }
}
