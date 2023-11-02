import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:futamap/screens/auth/login.dart';
import 'package:vector_graphics/vector_graphics.dart';
import '../../theme/colors.dart' as futa_map_colors;

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  late double _deviceHeight, _deviceWidth;
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: futa_map_colors.Colors.surface,
      body: SafeArea(
        child: SizedBox(
          width: _deviceWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SvgPicture(
                AssetBytesLoader('assets/svgs/undraw_login_design.svg.vec'),
                semanticsLabel: 'Futa-Map Logo',
              ),
              Container(
                margin: const EdgeInsets.only(top: 24),
                child: const Text(
                  "Please login to use this feature",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 24),
                width: _deviceWidth * .8,
                height: 50,
                child: OutlinedButton(
                  onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                    (Route<dynamic> route) => false,
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        futa_map_colors.Colors.onBackground),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
        ),
      ),
    );
  }
}
