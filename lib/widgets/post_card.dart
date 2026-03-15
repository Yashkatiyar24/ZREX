import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/post_model.dart';
import '../utils/constants.dart';
import '../providers/post_provider.dart';
import 'like_button.dart';
import 'save_button.dart';
import 'carousel_post.dart';

class PostCard extends ConsumerWidget {
  final Post post;

  const PostCard({super.key, required this.post});

  void _showSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Feature coming soon'),
        duration: Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Post Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(1.5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey[200]!, width: 0.5),
                ),
                child: CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(post.userAvatar),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                post.username,
                style: AppConstants.titleStyle,
              ),
              const Spacer(),
              const Icon(Icons.more_horiz, size: 20),
            ],
          ),
        ),

        // Post Content (Image/Carousel)
        CarouselPost(
          images: post.images,
          onDoubleTap: () => ref.read(postProvider.notifier).toggleLike(post.id),
        ),

        // Post Actions
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
          child: Row(
            children: [
              LikeButton(
                isLiked: post.isLiked,
                onTap: () => ref.read(postProvider.notifier).toggleLike(post.id),
              ),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: () => _showSnackBar(context),
                child: const Icon(FontAwesomeIcons.comment, size: 22, color: Colors.black),
              ),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: () => _showSnackBar(context),
                child: const Icon(FontAwesomeIcons.paperPlane, size: 22, color: Colors.black),
              ),
              const Spacer(),
              SaveButton(
                isSaved: post.isSaved,
                onTap: () => ref.read(postProvider.notifier).toggleSave(post.id),
              ),
            ],
          ),
        ),

        // Likes Count
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: Text(
            '${post.likes} likes',
            style: AppConstants.titleStyle,
          ),
        ),

        // Caption
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 6),
          child: RichText(
            text: TextSpan(
              style: AppConstants.bodyStyle,
              children: [
                TextSpan(
                  text: '${post.username} ',
                  style: AppConstants.titleStyle,
                ),
                TextSpan(text: post.caption),
              ],
            ),
          ),
        ),

        // Post Date
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: Text(
            post.timeAgo.toUpperCase(),
            style: AppConstants.greyStyle.copyWith(fontSize: 10, letterSpacing: 0.2),
          ),
        ),

        const SizedBox(height: 16),
      ],
    );
  }
}
