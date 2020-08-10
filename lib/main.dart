import 'package:flutter/material.dart';
import 'package:flutter_apps/network/api_service.dart';
import 'package:flutter_apps/ui/home_page.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
  _setupLogging();
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) => {
    print("${rec.level.name}; ${rec.time}: ${rec.message}")
  });


}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => ApiService.create(),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomePage(),
      ),
    );
  }
}
