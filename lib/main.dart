import 'package:dmb_timer_3/screens/AllTimers/AllTimersHome.dart';
import 'package:dmb_timer_3/screens/ChatScreen.dart';
import 'package:dmb_timer_3/screens/DocumentsScreen.dart';
import 'package:dmb_timer_3/screens/HomePage/MyHomePage.dart';
import 'package:dmb_timer_3/screens/RankScreen.dart';
import 'package:dmb_timer_3/screens/ShevronsScreen.dart';
import 'package:dmb_timer_3/screens/TthPage/TthScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        // ... app-specific localization delegate[s] here
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en'), // English
        const Locale('uk'), // Hebrew
        // ... other locales the app supports
      ],
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: MyHomePage.id,
      routes: {
        MyHomePage.id: (context) => MyHomePage(),
        AllTimersHome.id: (context) => AllTimersHome(),
        RankScreen.id: (context) => RankScreen(),
        TthList.id: (context) => TthList(),
        ListDocumentsScreen.id: (context) => ListDocumentsScreen(),
        ChatScreen.id: (context) => ChatScreen(),
        ShevronsScreen.id: (context) => ShevronsScreen(),
      },
      //  home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
