// ignore_for_file: unused_local_variable, unused_element

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:futamap/components/buttons.dart';
import 'package:futamap/components/loader.dart';
import 'package:futamap/components/text_field.dart';
import 'package:futamap/data/model/account.dart';
import 'package:futamap/screens/auth/login.dart';
import 'package:futamap/service/firebase_service.dart';
import '../../theme/colors.dart' as futa_map_colors;

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late double _deviceHeight, _deviceWidth;
  var showPassword = false;
  var _isLoading = false;

  final _auth = FirebaseAuthService();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    var nameError = false;

    var emailError = false;

    var passwordError = false;

    return Scaffold(
      backgroundColor: futa_map_colors.Colors.surface,
      body: SafeArea(
        child: Container(
          width: _deviceWidth,
          padding: EdgeInsets.only(
            top: _deviceHeight * .025,
          ),
          child: _isLoading
              ? const Center(child: Loader())
              : Column(
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
                          InputField(
                            _deviceWidth,
                            controller: _nameController,
                            backgroundColor:
                                futa_map_colors.Colors.primaryContainer,
                            hintText: 'eg James Oluseyi',
                            onChanged: (p0) => setState(() {
                              nameError = p0.isEmpty;
                            }),
                            error: nameError,
                            errorText: "Name is required",
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
                          InputField(
                            _deviceWidth,
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            backgroundColor:
                                futa_map_colors.Colors.primaryContainer,
                            hintText: 'eg name@example.com',
                            onChanged: (p0) => setState(() {
                              emailError = p0.isEmpty;
                            }),
                            error: emailError,
                            errorText: "Email is required",
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
                          InputField(
                            _deviceWidth,
                            controller: _passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            isPassword: true,
                            showPassword: showPassword,
                            backgroundColor:
                                futa_map_colors.Colors.primaryContainer,
                            hintText: '**********',
                            onChanged: (p0) => setState(() {
                              passwordError = p0.isEmpty;
                            }),
                            error: passwordError,
                            errorText: "Password is required",
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
                              signup();
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
                          googleButton(
                            width: _deviceWidth * .05,
                            signin: false,
                            onPressed: () =>
                                ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Coming soon...'),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          appleButton(
                            width: _deviceWidth * .05,
                            signin: false,
                            onPressed: () =>
                                ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Coming soon...'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          height: 1,
                          width: _deviceWidth,
                          color:
                              futa_map_colors.Colors.onSurface.withOpacity(.1),
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
                ),
        ),
      ),
    );
  }

  Future<void> signup() async {
    setState(() {
      _isLoading = true;
    });

    String name = _nameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.createAccount(email, password, name);

    setState(() {
      _isLoading = false;
    });

    if (user != null) {
      _updateUser(name, email, user);
    }
  }

  Future<void> _updateUser(String name, String email, User user) async {
    try {
      var db = FirebaseFirestore.instance;
      var data = Account(name, user.uid, email);
      await user.updateDisplayName(name).then(
            (_) => {
              db.collection("users").doc(user.uid).set(data.toMap()).then(
                    (value) => {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Account created successfully.'))),
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      ),
                    },
                  ),
            },
          );
      setState(() => _isLoading = false);
    } catch (e) {
      setState(() => _isLoading = false);
      debugPrint('$e');
    }
  }
}
