import 'package:flutter/material.dart';
import '../utils/constants.dart';

class StoriesBar extends StatelessWidget {
  final List<Map<String, String>> stories;

  const StoriesBar({super.key, required this.stories});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 115,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppConstants.igBorder, width: 0.5),
        ),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        itemCount: stories.length,
        itemBuilder: (context, index) {
          final story = stories[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 68,
                      height: 68,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: index == 0
                            ? null
                            : const LinearGradient(
                                colors: [
                                  Color(0xFFFBAA47),
                                  Color(0xFFD91A46),
                                  Color(0xFFA60F93),
                                ],
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                              ),
                        color: index == 0 ? Colors.transparent : null,
                      ),
                    ),
                    Container(
                      width: 64,
                      height: 64,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(story['avatar']!),
                    ),
                    if (index == 0)
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: const Icon(
                            Icons.add_circle,
                            color: AppConstants.igBlue,
                            size: 20,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 6),
                SizedBox(
                  width: 75,
                  child: Text(
                    story['username']!,
                    style: AppConstants.greyStyle.copyWith(
                      color: Colors.black,
                      fontSize: 11,
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
