import 'package:flutter/material.dart';
import 'package:flutterglobalyc/DatabaseHelper.dart'; 
import 'package:flutterglobalyc/DatabaseHelperUpdate.dart'; 

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Database Information',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DatabaseInfoPage(),
    );
  }
}

class DatabaseInfoPage extends StatefulWidget {
  @override
  _DatabaseInfoPageState createState() => _DatabaseInfoPageState();
}

class _DatabaseInfoPageState extends State<DatabaseInfoPage> {
  late Future<List<Map<String, dynamic>>> activeDevices;
  late Future<List<Map<String, dynamic>>> updates;

  @override
  void initState() {
    super.initState();
    activeDevices = DatabaseHelper().getAllData();
    updates = DatabaseHelperUpdate().getAllRecords();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Database Information'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<List<Map<String, dynamic>>>(
              future: activeDevices,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Hata: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  return buildDataList(snapshot.data!, 'Active Devices');
                } else {
                  return Text('No active device data found.');
                }
              },
            ),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: updates,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  return buildDataList(snapshot.data!, 'Updates');
                } else {
                  return Text('No update data found.');
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDataList(List<Map<String, dynamic>> data, String title) {
    return ExpansionTile(
      title: Text(title),
      children: data.map((item) => ListTile(
        title: Text(item.toString()),
      )).toList(),
    );
  }
}
