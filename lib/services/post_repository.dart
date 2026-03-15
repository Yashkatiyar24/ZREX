import 'dart:async';
import '../models/post_model.dart';

class PostRepository {
  final List<String> _avatars = [
    'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=200&h=200&fit=crop',
    'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200&h=200&fit=crop',
    'https://images.unsplash.com/photo-1599566150163-29194dcaad36?w=200&h=200&fit=crop',
    'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=200&h=200&fit=crop',
    'https://images.unsplash.com/photo-1527980965255-d3b416303d12?w=200&h=200&fit=crop',
  ];

  final List<String> _postImages = [
    'https://images.unsplash.com/photo-1682687220742-aba13b6e50ba?w=800&fit=crop',
    'https://images.unsplash.com/photo-1470071459604-3b5ec3a7fe05?w=800&fit=crop',
    'https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=800&fit=crop',
    'https://images.unsplash.com/photo-1501854140801-50d01698950b?w=800&fit=crop',
    'https://images.unsplash.com/photo-1447752875215-b2761acb3c5d?w=800&fit=crop',
    'https://images.unsplash.com/photo-1469474968028-56623f02e42e?w=800&fit=crop',
    'https://images.unsplash.com/photo-1501785888041-af3ef285b470?w=800&fit=crop',
    'https://images.unsplash.com/photo-1426604966145-70f052153595?w=800&fit=crop',
    'https://images.unsplash.com/photo-1472396961693-142e6e269027?w=800&fit=crop',
    'https://images.unsplash.com/photo-1433086966358-54859d0ed716?w=800&fit=crop',
  ];

  Future<List<Post>> getPosts({int page = 0, int limit = 10}) async {
    // Simulate network latency
    await Future.delayed(const Duration(milliseconds: 1500));

    return List.generate(limit, (index) {
      final actualIndex = page * limit + index;
      final isCarousel = actualIndex % 3 == 0;
      
      return Post(
        id: 'post_$actualIndex',
        username: 'user_${actualIndex + 1}',
        userAvatar: _avatars[actualIndex % _avatars.length],
        images: isCarousel 
          ? [
              _postImages[actualIndex % _postImages.length],
              _postImages[(actualIndex + 1) % _postImages.length],
              _postImages[(actualIndex + 2) % _postImages.length],
            ]
          : [_postImages[actualIndex % _postImages.length]],
        caption: 'This is a beautiful shot of nature #photography #nature #igclone Shot number $actualIndex.',
        likes: (actualIndex + 1) * 123,
        timeAgo: '${actualIndex + 1} hours ago',
      );
    });
  }

  List<Map<String, String>> getStories() {
    return List.generate(10, (index) => {
      'username': index == 0 ? 'Your Story' : 'friend_$index',
      'avatar': _avatars[index % _avatars.length],
    });
  }
}
