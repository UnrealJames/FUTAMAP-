import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:futamap/screens/auth/onboarding.dart';

void main() {
  runApp(App(const OnboardingScreen()));
}

class App extends StatelessWidget {
  Widget home;
  App(this.home, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: "Futa-Map",
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF9FAFB),
      ),
      home: home,
    );
  }
}
