import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/post_model.dart';
import '../services/post_repository.dart';

class PostState {
  final List<Post> posts;
  final bool isLoading;
  final bool isLoadingMore;
  final int currentPage;
  final bool hasReachedMax;

  PostState({
    required this.posts,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.currentPage = 0,
    this.hasReachedMax = false,
  });

  PostState copyWith({
    List<Post>? posts,
    bool? isLoading,
    bool? isLoadingMore,
    int? currentPage,
    bool? hasReachedMax,
  }) {
    return PostState(
      posts: posts ?? this.posts,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      currentPage: currentPage ?? this.currentPage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}

class PostNotifier extends StateNotifier<PostState> {
  final PostRepository _repository;

  PostNotifier(this._repository) : super(PostState(posts: [])) {
    fetchInitialPosts();
  }

  Future<void> fetchInitialPosts() async {
    state = state.copyWith(isLoading: true);
    try {
      final posts = await _repository.getPosts(page: 0);
      state = state.copyWith(
        posts: posts,
        isLoading: false,
        currentPage: 0,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> fetchMorePosts() async {
    if (state.isLoadingMore || state.hasReachedMax) return;

    state = state.copyWith(isLoadingMore: true);
    try {
      final nextPage = state.currentPage + 1;
      final newPosts = await _repository.getPosts(page: nextPage);
      
      if (newPosts.isEmpty) {
        state = state.copyWith(isLoadingMore: false, hasReachedMax: true);
      } else {
        state = state.copyWith(
          posts: [...state.posts, ...newPosts],
          isLoadingMore: false,
          currentPage: nextPage,
        );
      }
    } catch (e) {
      state = state.copyWith(isLoadingMore: false);
    }
  }

  void toggleLike(String postId) {
    state = state.copyWith(
      posts: state.posts.map((post) {
        if (post.id == postId) {
          final isLiked = !post.isLiked;
          return post.copyWith(
            isLiked: isLiked,
            likes: isLiked ? post.likes + 1 : post.likes - 1,
          );
        }
        return post;
      }).toList(),
    );
  }

  void toggleSave(String postId) {
    state = state.copyWith(
      posts: state.posts.map((post) {
        if (post.id == postId) {
          return post.copyWith(isSaved: !post.isSaved);
        }
        return post;
      }).toList(),
    );
  }
}

final postRepositoryProvider = Provider((ref) => PostRepository());

final postProvider = StateNotifierProvider<PostNotifier, PostState>((ref) {
  final repository = ref.watch(postRepositoryProvider);
  return PostNotifier(repository);
});
