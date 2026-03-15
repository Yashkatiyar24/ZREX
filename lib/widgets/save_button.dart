import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SaveButton extends StatelessWidget {
  final bool isSaved;
  final VoidCallback onTap;

  const SaveButton({
    super.key,
    required this.isSaved,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        isSaved ? FontAwesomeIcons.solidBookmark : FontAwesomeIcons.bookmark,
        color: Colors.black,
        size: 24,
      ),
    );
  }
}
