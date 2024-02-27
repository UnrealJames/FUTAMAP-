import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:futamap/components/empty.dart';
import 'package:futamap/data/model/account.dart';
import 'package:futamap/screens/auth/login.dart';
import 'package:futamap/screens/home/place_detail.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vector_graphics/vector_graphics.dart';
import '../../theme/colors.dart' as futa_map_colors;
import 'package:futamap/components/location.dart';
import 'package:futamap/data/model/location.dart';
import 'package:collection/collection.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  late double _deviceWidth;

  final user = FirebaseAuth.instance.currentUser;
  final _db = FirebaseFirestore.instance;
  final TextEditingController _searchController = TextEditingController();
  final List<Location> _locations = [];
  final List<Location> _filteredLocations = [];

  Account? account;

  @override
  void initState() {
    super.initState();
    if (user != null) {
      _getUserInfo(user!).then((value) => {setState(() => account = value)});
      _getLocations();
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: futa_map_colors.Colors.surface,
      body: SafeArea(
        child: SizedBox(
          width: _deviceWidth,
          child: (user != null)
              ? Container(
                  child: _locations.isEmpty
                      ? const Empty(
                          "No saved places", "You havent saved any places yet.")
                      : Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.all(16),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: futa_map_colors.Colors.primary),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    color: futa_map_colors.Colors.primary,
                                    size: 30,
                                  ),
                                  SizedBox(
                                    width: _deviceWidth * .7,
                                    child: TextFormField(
                                      controller: _searchController,
                                      cursorColor: const Color(0xFF3734A9),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                      decoration: const InputDecoration(
                                        fillColor: Color(0xFFF9FAFB),
                                        filled: true,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 1,
                                            color: Colors.transparent,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 1,
                                            color: Colors.transparent,
                                          ),
                                        ),
                                        hintText: "Search here",
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            StaggeredGrid.count(
                              crossAxisCount: 2,
                              children: _locations
                                  .mapIndexed(
                                    (i, e) => locationComponent(
                                      location: e,
                                      index: i,
                                      onPress: (p0) => {
                                        Navigator.pushNamed(
                                          context,
                                          PlaceDetailScreen.routeName,
                                          arguments: e,
                                        )
                                      },
                                    ),
                                  )
                                  .toList(),
                            )
                          ],
                        ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SvgPicture(
                      AssetBytesLoader(
                          'assets/svgs/undraw_login_design.svg.vec'),
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
                        onPressed: () =>
                            Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                          (Route<dynamic> route) => false,
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            futa_map_colors.Colors.onBackground,
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
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

  Future<Account?> _getUserInfo(User user) async {
    debugPrint("${user.uid}");
    Account? account;
    try {
      await _db.collection("users").doc(user.uid).get().then(
            (value) => {account = Account.fromFirestore(value, null)},
          );
      // setState(() => _isLoading = false);
      return account;
    } catch (e) {
      // setState(() => _isLoading = false);
      debugPrint('$e');
      return null;
    }
  }

  Future<void> _getLocations() async {
    debugPrint("GetLocations called: $account");
    List<Location> locations = [];
    await _db.collection('places').get().then(
          (value) => {
            for (int i = 0; i < value.docs.length; i++)
              locations.add(Location.fromMap(value.docs[i]))
          },
        );
    setState(() {
      _locations.addAll(locations.where(
          (element) => account?.bookmarks?.contains(element.id) ?? false));
      // _locations.addAll(locations);
      if (_searchController.text.isEmpty) {
        _filteredLocations.addAll(_locations);
      }
    });
  }
}
