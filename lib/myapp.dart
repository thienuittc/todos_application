import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'src/screens/homescreen.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TO-DO Application',
      theme: ThemeData(
          primaryColor: Color(0xffa3b1e0), accentColor: Color(0xff96a9e3)),
      home: FutureBuilder(
        future: Hive.openBox('todos'),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError)
              return Text(snapshot.error.toString());
            else
              return Home();
          } else
            return Scaffold();
        },
      ),
    );
  }

  @override
  void dispose() {
    Hive.box('todos').compact();
    Hive.close();
    super.dispose();
  }
}
