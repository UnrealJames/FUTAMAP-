import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late double _deviceHeight, _deviceWidth;
  var showPassword = false;
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    var email = '';
    var password = '';

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
            width: _deviceWidth,
            padding: EdgeInsets.symmetric(
              horizontal: _deviceWidth * .05,
              vertical: _deviceHeight * .05,
            ),
            child: ListView(
              children: [
                const Text(
                  'Hi There! 👋',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const Text(
                  'Create an account to get started',
                  style: TextStyle(
                    color: Color(0xFF6B7280),
                    fontWeight: FontWeight.normal,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 32),
                const SizedBox(height: 16),
                const SizedBox(height: 24),
                const SizedBox(height: 32),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 1.5,
                      width: _deviceWidth * .4,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment(0.8, 1),
                          colors: <Color>[
                            Colors.white,
                            Color(0xFFCCCCCC),
                          ], // Gradient
                          tileMode: TileMode.mirror,
                        ),
                      ),
                    ),
                    const Text(
                      'OR',
                      style: TextStyle(
                        color: Color(0xFFCCCCCC),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      height: 1.5,
                      width: _deviceWidth * .4,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment(1, 1),
                          colors: <Color>[
                            Color(0xFFCCCCCC),
                            Colors.white,
                          ], // Gradient
                          tileMode: TileMode.mirror,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(
                        color: Color(0xFF6B7280),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
