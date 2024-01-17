import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vector_graphics/vector_graphics.dart';

class Empty extends StatelessWidget {
  const Empty(this.title, this.description, {super.key});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SvgPicture(
          AssetBytesLoader('assets/svgs/undraw_empty_design.svg.vec'),
          semanticsLabel: 'Craft Logo',
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: "SpaceGrotesk",
          ),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: const TextStyle(
            fontSize: 12,
            fontFamily: "SpaceGrotesk",
          ),
        ),
      ],
    );
  }
}
