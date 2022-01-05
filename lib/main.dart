import 'package:flutter/material.dart';

import 'mysql.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Database GUI',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Database GUI'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  var title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  var db = Mysql();
  var title;
  @override
  void initState() {
    //This will execute at the start of loading the app so we have access to the correct table in db
    db.getConnection().then((conn) {
      String sql = 'use providers';
      conn.query(sql);
    });

    super.initState();
  }

  void _getTitle() {
    db.getConnection().then((conn) {
      String sql =
          "select * from nursinghome where name='Garden Village';"; //Just an easy example
      conn.query(sql).then((results) {
        for (var row in results) {
          setState(() {
            title = row['name']; //Can index by name or index
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text('Title:'),
            Text('$title'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getTitle,
        child: Icon(Icons.add_box_sharp),
      ),
    );
  }
}
