import 'package:flutter/material.dart';


class MmDermelux extends StatefulWidget {
  @override
  _MmDermeluxState createState() => _MmDermeluxState();
}

class _MmDermeluxState extends State<MmDermelux> {

  bool isHydroWand = false;
  bool isCooling = false;
  bool isOxy= false;
  int simpleIntInput = 0;
  double receiveTempData= 0.0; 
  bool powerCheckResult = true; // İlk test raporu, başlangıçta true
  bool temperatureCheckResult = false; // İkinci test raporu, başlangıçta false
 
 











 

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
           '$receiveTempData °C',
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
}

void main() {
  runApp(MaterialApp(
    home: MmDermelux(),
  ));
}