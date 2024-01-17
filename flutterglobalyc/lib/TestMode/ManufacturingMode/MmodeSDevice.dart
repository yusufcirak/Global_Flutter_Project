import 'package:flutter/material.dart';
import 'package:flutterglobalyc/TestMode/ManufacturingMode/MmodeSoftwareUpdate.dart';
import 'package:flutterglobalyc/TestMode/ManufacturingMode/DeviceTestMode/MmHydroVerstand.dart';
import 'package:flutterglobalyc/TestMode/ManufacturingMode/DeviceTestMode/MmVerstandHD.dart';
import 'package:flutterglobalyc/TestMode/ManufacturingMode/DeviceTestMode/MmCoolRestore.dart';



class MmodeSDevice extends StatefulWidget {
  @override
  _MmodeSDeviceState createState() => _MmodeSDeviceState();
}


class _MmodeSDeviceState extends State<MmodeSDevice> {
   
  bool _isLoading = false;
  bool _showProgressBar = false;
  String receivedData = ""; // Varsayılan başlangıç değeri
  final List<String> deviceList = [
    
    "DermeLuxx",
    "HydroVerstand",
    "Verstand HD",
    "CoolRestore",
  ];
  String _selectedDevice = "DermeLuxx";

  Future<void> _startProcess() async {
    setState(() {
      _isLoading = true;
      _showProgressBar = false; 
    });

    const delayDuration = Duration(seconds: 5);

    await Future.delayed(delayDuration);

    setState(() {
      _isLoading = false;
    });

    print("Selected Device: $_selectedDevice");

    if (_selectedDevice == "DermeLuxx") {

        Navigator.push(context, MaterialPageRoute(builder: (context) => MmodeSoftwareUpdate()));

    } else if (_selectedDevice == "HydroVerstand") {
      Navigator.push(context, MaterialPageRoute(builder: (context) => MmHydroVerstand()));
    }else if (_selectedDevice == "Verstand HD") {
      Navigator.push(context, MaterialPageRoute(builder: (context) => MmVerstandHD()));
  }else if (_selectedDevice == "CoolRestore") {
      Navigator.push(context, MaterialPageRoute(builder: (context) => MmCoolRestore()));
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
                    'Manufacturing Mode',
                    style: TextStyle(fontSize: 30, color: Colors.black),
                  ),
                ),
                SizedBox(height: 50.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
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
                    ElevatedButton(
                      onPressed: _isLoading
                          ? null
                          : () {
                              _startProcess();
                             
                            },
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(width: 2.0, color: Colors.blue),
                        padding: EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 30,
                        ),
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
          // Progress bar eklemek için
          if (_isLoading)
            Positioned(
              top: 650.0,
              left: 0,
              right: 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Please wait...",
                    textAlign: TextAlign.center, // Yazıyı ortalamak için bu özelliği ekledik
                  ),
                ],
              ),
            ),
          if (_showProgressBar)
            Positioned(
              top: 650.0,
              left: 0,
              right: 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Please wait...",
                    textAlign: TextAlign.center, // Yazıyı ortalamak için bu özelliği ekledik
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

void main() {
  runApp(MaterialApp(
    home: MmodeSDevice(),
  ));
}
