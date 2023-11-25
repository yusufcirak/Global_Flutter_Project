import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutterglobalyc/HomePage/Treatment/Function1Steps/Function1Step2.dart';


class Function1Page extends StatefulWidget {
  @override
  _Function1PageState createState() => _Function1PageState();
  
}

class _Function1PageState extends State<Function1Page> {
  
  bool startButtonVisible = true;
  bool timetextVisible = false;
  bool resumebtnVisible = false;
  bool pausebtnVisible = false;
   bool NextStepVisible = false;
  int remainingTime = 8 * 60; // 8 dakika
  late Timer timer;
  String frequency = '3 Hz';
   String? selectedHz = "3 Hz"; 
  
   Future<void> showHzDialog() async {
    selectedHz = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("Choose the frequency level"),
              content: Container(
                width: 200,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RadioListTile<String>(
                      title: Text("1 Hz"),
                      value: "1 Hz",
                      groupValue: selectedHz,
                      onChanged: (String? value) {
                        setState(() {
                          selectedHz = value;
                        });
                      },
                    ),
                    RadioListTile<String>(
                      title: Text("2 Hz"),
                      value: "2 Hz",
                      groupValue: selectedHz,
                      onChanged: (String? value) {
                        setState(() {
                          selectedHz = value;
                        });
                      },
                    ),
                    
                       RadioListTile<String>(
                      title: Text("3 Hz"),
                      value: "3 Hz",
                      groupValue: selectedHz,
                      onChanged: (String? value) {
                        setState(() {
                          selectedHz = value;
                        });
                      },
                    ),

                       RadioListTile<String>(
                      title: Text("4 Hz"),
                      value: "4 Hz",
                      groupValue: selectedHz,
                      onChanged: (String? value) {
                        setState(() {
                          selectedHz = value;
                        });
                      },
                    ),
                       RadioListTile<String>(
                      title: Text("5 Hz"),
                      value: "5 Hz",
                      groupValue: selectedHz,
                      onChanged: (String? value) {
                        setState(() {
                          selectedHz = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, "Cancel");
                  },
                  child: Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, selectedHz);
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
      },
    );

    if (selectedHz != null && selectedHz != "Cancel") {
      // Eğer kullanıcı bir Hz seçtiyse ve "Cancel" butonuna basmadıysa, istediğiniz işlemi yapabilirsiniz
            setState(() {
            switch (selectedHz) {
              case "1 Hz":
             frequency="1 Hz";
                break;
              case "2 Hz":
                
                  frequency="2 Hz";
        
                break;
              case "3 Hz":
                
                 frequency="3 Hz";
                break;
              case "4 Hz":
                

                frequency="4 Hz";
                break;
              case "5 Hz":
               

                frequency="5 Hz";
                break;
              default:
              

                break;
    }
  });
    }
  }
  
     
  
  
  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        if (remainingTime < 1) {
          timer.cancel();
          timetextVisible = false; // Geri sayım tamamlandığında gizle
          resumebtnVisible = false;
          pausebtnVisible = false;

        } else {
          remainingTime--;
        }
      });
    });
  }

  void pauseTimer() {
    timer.cancel(); // Timer'ı iptal et
    setState(() {
      resumebtnVisible = true;
      pausebtnVisible = false;
    });
  }

  void resumeTimer() {
    startTimer(); // Duraklatılan timer'ı tekrar başlat
    setState(() {
      resumebtnVisible = false;
      pausebtnVisible = true;
    });
  }

  void stopTimer() {
    timer.cancel(); // Timer'ı iptal et
    setState(() {
      startButtonVisible = true;
      timetextVisible = false;
      resumebtnVisible = false;
      pausebtnVisible = false;
      remainingTime = 8 * 60; // Geri sayımı sıfırla
    });
  }

  void startButtonPressed() {
    setState(() {
      startButtonVisible = false;
      timetextVisible = true;
      pausebtnVisible = true;

    });

    startTimer();
     const Duration duration = Duration(seconds: 30);

  Timer(duration, () {
    setState(() {
      NextStepVisible = true;
    });
    
  });
  }
void NextStep() {
  stopTimer();
  NextStepVisible = false;

   Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Function1Step2(),
      ),
   );
 
}

  @override
  void dispose() {
    timer.cancel(); // Widget kapatıldığında timer'ı temizle
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(

          leading: IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
          ),
          title: Text('ULEVATE VIVAFACIAL(1/5)'),
          backgroundColor: Color(0xFF84BD00),
         
  
          actions: [
            TextButton(
              onPressed: () {
               showHzDialog();
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
              ),
              child: Row(
                children: [
                  Image.asset(
                    'lib/images/iconfr.png',
                    width: 20,
                    height: 20,
                  ),
                  SizedBox(width: 8),
                 Text(
                  frequency,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  ),
              
                ],
              ),

            ),
            TextButton(
              onPressed: () {
                // CLOSE butonuna tıklanınca yapılacak işlemler
              },
              child: Text(
                'CLOSE',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            SizedBox(width: 16),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                margin: EdgeInsets.all(16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Image.asset(
                        'lib/images/st1.jpg',
                        width: 250,
                        height: 150,
                      ),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'VIVAFACIAL Step 1',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 250),
                              Text(
                                'STEP 1/5',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              SizedBox(width: 0),
                              Image.asset(
                                'lib/images/iconvivafacial.png',
                                width: 50,
                                height: 50,
                              ),
                              SizedBox(
                                height: 20,
                                width: 10,
                              ),
                              Text(
                                'VIVAPEEL Applicator',
                                style: TextStyle(
                                  color: Color(0x57000000),
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(height: 70),
                              InkWell(
                                onTap: startButtonPressed,
                                child: Visibility(
                                  visible: startButtonVisible,
                                  child: Container(
                                    width: 187,
                                    height: 44,
                                    margin: EdgeInsets.only(left: 0),
                                    decoration: BoxDecoration(
                                      color: Color(0xFF84BD00),
                                      borderRadius: BorderRadius.circular(25),
                                      border: Border.all(color: Colors.grey),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.play_arrow,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          'START (8 min)',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              
                              Visibility(
                                visible: timetextVisible,
                                child: Text(
                                  '${(remainingTime ~/ 60).toString().padLeft(2, '0')}:${(remainingTime % 60).toString().padLeft(2, '0')}',
                                  style: TextStyle(fontSize: 48),
                                ),
                              ),
                                          SizedBox(width: 20),
                              InkWell(
                                onTap: resumeTimer,
                                child: Visibility(
                                  visible: resumebtnVisible,
                                  child: Container(
                                    width: 187,
                                    height: 44,
                                    margin: EdgeInsets.only(left: 0),
                                    decoration: BoxDecoration(
                                      color: Color(0xFF84BD00),
                                      borderRadius: BorderRadius.circular(25),
                                      border: Border.all(color: Colors.grey),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.play_arrow,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          'Resume',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                           
                              InkWell(
                                onTap: pauseTimer,
                                child: Visibility(
                                  visible: pausebtnVisible,
                                  child: Container(
                                    width: 187,
                                    height: 44,
                                    margin: EdgeInsets.only(left: 0),
                                    decoration: BoxDecoration(
                                      color: Color(0xFF84BD00),
                                      borderRadius: BorderRadius.circular(25),
                                      border: Border.all(color: Colors.grey),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.pause,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          'Pause',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                      
                              ),

                                  SizedBox(width: 20),
                                  InkWell(
                                onTap: NextStep,
                                
                                child: Visibility(
                                  visible: NextStepVisible,
                                  child: Container(
                                    width: 187,
                                    height: 44,
                                    margin: EdgeInsets.only(left: 0),
                                    decoration: BoxDecoration(
                                      color: Color(0xFF84BD00),
                                      borderRadius: BorderRadius.circular(25),
                                      border: Border.all(color: Colors.grey),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        
                                        SizedBox(width: 8),
                                        Text(
                                          'Next Step',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
  
    Card(
  margin: EdgeInsets.all(16),
  child: Padding(
    padding: const EdgeInsets.all(16.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center, // Yatayda ortala
      children: [
        Image.asset(
          'lib/images/stepresim.jpg',
         
          
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // İkinci kartın içeriği burada olacak
          ],
        ),
      ],
    ),
  ),
),

   Card(
  margin: EdgeInsets.all(16),
  child: Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'VIVAPEEL',
              style: TextStyle(
                fontSize: 20,
               color: Color(0xFF84BD00),
                
              ),
            ),
            SizedBox(width: 20),
            // İkinci kartın içeriği burada olacak
          ],
        ),
        SizedBox(height: 20),
       Row(
          children: [
            Text(
              'P.O.E. Positive Oxygen Exfoliation',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              
              ),
            ),
            SizedBox(width: 20),
            // İkinci kartın içeriği burada olacak
          ],
        ),

         Row(
          children: [
            Text(
              'P.O.E. Positive Oxygen Exfoliation',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              
              ),
            ),
            SizedBox(width: 20),
            // İkinci kartın içeriği burada olacak
          ],
        ),
      ],
    ),
  ),
),
        
      





            ],
          
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Function1Page(),
  ));
}
