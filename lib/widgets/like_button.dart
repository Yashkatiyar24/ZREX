import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../utils/constants.dart';

class LikeButton extends StatelessWidget {
  final bool isLiked;
  final VoidCallback onTap;

  const LikeButton({
    super.key,
    required this.isLiked,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return ScaleTransition(scale: animation, child: child);
        },
        child: Icon(
          isLiked ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
          key: ValueKey<bool>(isLiked),
          color: isLiked ? AppConstants.igRed : Colors.black,
          size: 24,
        ),
      ),
    );
  }
}
