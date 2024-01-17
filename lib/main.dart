import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:futamap/firebase_options.dart';
import 'package:futamap/screens/auth/onboarding.dart';
import 'package:futamap/screens/home/home.dart';
import 'package:futamap/screens/home/navigation.dart';
import 'package:futamap/screens/home/place_detail.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  User? user = FirebaseAuth.instance.currentUser;
  runApp(App((user != null) ? const HomeScreen() : const OnboardingScreen()));
}

class App extends StatelessWidget {
  final Widget home;
  const App(this.home, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: "Futa-Map",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF9FAFB),
      ),
      home: home,
      routes: {
        PlaceDetailScreen.routeName: (context) => const PlaceDetailScreen(),
        NavigationScreen.routeName: (context) => const NavigationScreen(),
      },
    );
  }
}
