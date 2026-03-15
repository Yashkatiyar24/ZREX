import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../providers/post_provider.dart';
import '../widgets/post_card.dart';
import '../widgets/stories_bar.dart';
import '../widgets/shimmer_post.dart';
import '../utils/constants.dart';

class HomeFeedScreen extends ConsumerStatefulWidget {
  const HomeFeedScreen({super.key});

  @override
  ConsumerState<HomeFeedScreen> createState() => _HomeFeedScreenState();
}

class _HomeFeedScreenState extends ConsumerState<HomeFeedScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 1000) {
      ref.read(postProvider.notifier).fetchMorePosts();
    }
  }

  @override
  Widget build(BuildContext context) {
    final postState = ref.watch(postProvider);
    final stories = ref.watch(postRepositoryProvider).getStories();

    return Scaffold(
      backgroundColor: AppConstants.secondaryColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: Image.network(
          AppConstants.logoUrl,
          height: 32,
        ),
        actions: [
          IconButton(
            icon: const Icon(FontAwesomeIcons.heart, color: Colors.black, size: 22),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(FontAwesomeIcons.paperPlane, color: Colors.black, size: 22),
            onPressed: () {},
          ),
          const SizedBox(width: 4),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0.5),
          child: Container(
            color: AppConstants.igBorder,
            height: 0.5,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.read(postProvider.notifier).fetchInitialPosts(),
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: StoriesBar(stories: stories),
            ),
            if (postState.isLoading)
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => const ShimmerPost(),
                  childCount: 5,
                ),
              )
            else
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index < postState.posts.length) {
                      return PostCard(post: postState.posts[index]);
                    } else if (postState.isLoadingMore) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 32),
                        child: Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.grey,
                          ),
                        ),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                  childCount: postState.posts.length + (postState.isLoadingMore ? 1 : 0),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
