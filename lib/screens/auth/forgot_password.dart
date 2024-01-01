// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:futamap/components/buttons.dart';
import 'package:futamap/components/textfields.dart';
import '../../theme/colors.dart' as futa_map_colors;

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late double _deviceHeight, _deviceWidth;
  var showPassword = false;
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    var email = '';

    return Scaffold(
      backgroundColor: futa_map_colors.Colors.surface,
      body: SafeArea(
        child: Container(
          width: _deviceWidth,
          padding: EdgeInsets.only(
            top: _deviceHeight * .025,
            left: _deviceWidth * .05,
            right: _deviceWidth * .05,
          ),
          child: ListView(
            shrinkWrap: true,
            children: [
              const Align(
                alignment: Alignment.center,
                child: Text(
                  "Reset Password",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: futa_map_colors.Colors.onSurface,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "Hi there, kindly enter your email to reset your password",
                style: TextStyle(
                  color: futa_map_colors.Colors.onSurface,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
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
                backgroundColor: futa_map_colors.Colors.primaryContainer,
                hintText: 'eg name@example.com',
                onChanged: (p0) => setState(() {
                  email = p0;
                }),
              ),
              const SizedBox(height: 24),
              defaultButton(
                width: _deviceWidth * .05,
                onPressed: () => {},
                text: "Reset Password",
                backgroundColor: futa_map_colors.Colors.primary,
                textColor: futa_map_colors.Colors.onPrimary,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
