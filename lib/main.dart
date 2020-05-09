import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reader/page/home/home.dart';
import 'package:reader/page/search/search.dart';
import 'package:reader/view/glow_notification_widget.dart';

void main() {
  runApp(MyApp());
  SystemUiOverlayStyle systemUiOverlayStyle =
      SystemUiOverlayStyle(statusBarColor: Colors.transparent);
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GlowNotificationWidget(
      MaterialApp(
        title: 'Flutter Reader',
        theme: ThemeData(
          primarySwatch: Colors.red,
          primaryColor: Colors.red,
          backgroundColor: Colors.white,
          brightness: Brightness.light,
          platform: TargetPlatform.android,
        ),
        home: HomePage(),
        routes: <String, WidgetBuilder>{
          '/home': (_) => HomePage(),
          '/search': (_) => SearchPage(),
        },
      ),
    );
  }
}
