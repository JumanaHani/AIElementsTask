import 'package:flutter/material.dart';
import 'package:test_jumana/secondpage.dart';

import 'firstpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Flutter Demo',

      home: firstpage(),
      routes:
      {
        secondpage.routename: (ctx) => secondpage(),
      },
    );
  }
}

