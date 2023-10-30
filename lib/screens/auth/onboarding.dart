import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:futamap/screens/home/home.dart';
import 'package:vector_graphics/vector_graphics.dart';
import '../../theme/colors.dart' as futa_map_colors;

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<StatefulWidget> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late double _deviceHeight, _deviceWidth;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        color: futa_map_colors.Colors.primary,
        padding: EdgeInsets.symmetric(
          horizontal: _deviceWidth * 0.05,
          vertical: _deviceHeight * .02,
        ),
        height: _deviceHeight,
        width: _deviceWidth,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SvgPicture(
                    AssetBytesLoader('assets/svgs/futa_map_logo.svg.vec'),
                    semanticsLabel: 'Futa-Map Logo',
                  ),
                  SizedBox(
                    width: _deviceWidth * .8,
                    child: const Text(
                      "A comprehensive and holistic navigation system for the Federal University of Technology, Akure.",
                      style: TextStyle(
                        color: futa_map_colors.Colors.onPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 16),
                        width: _deviceWidth * .8,
                        height: 50,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => const HomeScreen()),
                              (Route<dynamic> route) => false,
                            );
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => const HomeScreen(),
                            //   ),
                            // );
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                futa_map_colors.Colors.primaryContainer),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                          child: const Text(
                            "Get Started",
                            style: TextStyle(
                              color: futa_map_colors.Colors.onPrimaryContainer,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 16),
                        width: _deviceWidth * .8,
                        height: 50,
                        child: OutlinedButton(
                          onPressed: () => {},
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                futa_map_colors.Colors.onBackground),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              color: futa_map_colors.Colors.onPrimary,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: _deviceWidth * .9,
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        const Text(
                          "By continuing, you agree to our",
                          style: TextStyle(
                            color: futa_map_colors.Colors.onPrimary,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                        TextButton(
                          onPressed: () => {},
                          child: const Text(
                            "Terms",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: futa_map_colors.Colors.onPrimary),
                          ),
                        ),
                        const Text(
                          "and",
                          style: TextStyle(
                            color: futa_map_colors.Colors.onPrimary,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                        TextButton(
                          onPressed: () => {},
                          child: const Text(
                            "Privacy Policy",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: futa_map_colors.Colors.onPrimary),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
