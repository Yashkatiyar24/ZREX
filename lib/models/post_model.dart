class Post {
  final String id;
  final String username;
  final String userAvatar;
  final List<String> images;
  final String caption;
  final int likes;
  final bool isLiked;
  final bool isSaved;
  final String timeAgo;

  Post({
    required this.id,
    required this.username,
    required this.userAvatar,
    required this.images,
    required this.caption,
    required this.likes,
    this.isLiked = false,
    this.isSaved = false,
    required this.timeAgo,
  });

  Post copyWith({
    bool? isLiked,
    bool? isSaved,
    int? likes,
  }) {
    return Post(
      id: id,
      username: username,
      userAvatar: userAvatar,
      images: images,
      caption: caption,
      likes: likes ?? this.likes,
      isLiked: isLiked ?? this.isLiked,
      isSaved: isSaved ?? this.isSaved,
      timeAgo: timeAgo,
    );
  }
}
