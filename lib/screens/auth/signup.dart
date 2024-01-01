// ignore_for_file: unused_local_variable, unused_element

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:futamap/components/buttons.dart';
import 'package:futamap/components/textfields.dart';
import 'package:futamap/screens/auth/login.dart';
import '../../theme/colors.dart' as futa_map_colors;

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late double _deviceHeight, _deviceWidth;
  var showPassword = false;
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    var name = "";
    var email = '';
    var password = '';

    return Scaffold(
      backgroundColor: futa_map_colors.Colors.surface,
      body: SafeArea(
        child: Container(
            width: _deviceWidth,
            padding: EdgeInsets.only(
              top: _deviceHeight * .025,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: _deviceWidth,
                  padding: EdgeInsets.only(
                    top: 12,
                    bottom: _deviceHeight * .025,
                    left: _deviceWidth * .05,
                    right: _deviceWidth * .05,
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Create Account",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: futa_map_colors.Colors.onSurface,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "Kindly provide the few details below and we will setup your account ",
                        style: TextStyle(
                          color: futa_map_colors.Colors.onSurface,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        "Display Name",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: futa_map_colors.Colors.onSurface),
                      ),
                      const SizedBox(height: 8),
                      textField(
                        width: _deviceWidth,
                        backgroundColor:
                            futa_map_colors.Colors.primaryContainer,
                        hintText: 'eg James Oluseyi',
                        onChanged: (p0) => setState(() {
                          name = p0;
                        }),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        "Email Address",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: futa_map_colors.Colors.onSurface),
                      ),
                      const SizedBox(height: 8),
                      textField(
                        width: _deviceWidth,
                        backgroundColor:
                            futa_map_colors.Colors.primaryContainer,
                        hintText: 'eg name@example.com',
                        onChanged: (p0) => setState(() {
                          email = p0;
                        }),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        "Password",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: futa_map_colors.Colors.onSurface),
                      ),
                      const SizedBox(height: 8),
                      passwordTextField(
                        showPassword: showPassword,
                        width: _deviceWidth,
                        backgroundColor:
                            futa_map_colors.Colors.primaryContainer,
                        hintText: '**********',
                        onChanged: (p0) => setState(() {
                          password = p0;
                        }),
                        onPressed: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                      ),
                      const SizedBox(height: 24),
                      defaultButton(
                        width: _deviceWidth * .05,
                        onPressed: () {
                          // UserCredential? userCredential;
                          // _createAccount(email, password).whenComplete(
                          //   () => Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => const LoginScreen(),
                          //     ),
                          //   ),
                          // );
                        },
                        text: "Create Account",
                        backgroundColor: futa_map_colors.Colors.primary,
                        textColor: futa_map_colors.Colors.onPrimary,
                      ),
                      const SizedBox(height: 16),
                      const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "OR",
                          style: TextStyle(
                            color: futa_map_colors.Colors.onSurface,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      googleButton(width: _deviceWidth * .05, signin: false),
                      const SizedBox(height: 16),
                      appleButton(width: _deviceWidth * .05, signin: false),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Container(
                      height: 1,
                      width: _deviceWidth,
                      color: futa_map_colors.Colors.onSurface.withOpacity(.1),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account?",
                          style: TextStyle(
                            color: futa_map_colors.Colors.onSurface,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        TextButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          ),
                          child: const Text(
                            "Sign in.",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: futa_map_colors.Colors.primary),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }

  Future<UserCredential?> _createAccount(String email, String password) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('The password provided is too weak.')));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('The account already exists for that email.')));
      }
      return null;
    } catch (e) {
      debugPrint('$e');
      return null;
    }
  }
}
