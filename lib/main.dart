import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:textsync/components/dismissable.dart';
import 'package:textsync/states/homescreen.dart';
import 'package:textsync/states/loginscreen.dart';
import 'package:textsync/userclass.dart';
import 'color_schemes.g.dart' as colorscheme;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoggedIn = false;
  @override
  void initState() {
    //Runs function on launch
    super.initState();
    getUserStatus();
  }

  getUserStatus() async {
    await UserClass.getUserStatus().then((value) {
      if (value != null) {
        _isLoggedIn = value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DismissableWidget(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TextSync',
        theme: ThemeData(
            useMaterial3: true, colorScheme: colorscheme.lightColorScheme),
        darkTheme: ThemeData(
            useMaterial3: true, colorScheme: colorscheme.darkColorScheme),
        themeMode: ThemeMode.system,
        home: _isLoggedIn ? HomeScreen() : LoginScreen(),
      ),
    );
  }
}
