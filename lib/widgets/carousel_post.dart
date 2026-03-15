import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:photo_view/photo_view.dart';
import '../utils/constants.dart';

class CarouselPost extends StatefulWidget {
  final List<String> images;
  final VoidCallback? onDoubleTap;

  const CarouselPost({super.key, required this.images, this.onDoubleTap});

  @override
  State<CarouselPost> createState() => _CarouselPostState();
}

class _CarouselPostState extends State<CarouselPost> with TickerProviderStateMixin {
  int _currentIndex = 0;
  bool _showHeart = false;
  late AnimationController _heartController;
  late Animation<double> _heartAnimation;

  @override
  void initState() {
    super.initState();
    _heartController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _heartAnimation = Tween<double>(begin: 0.0, end: 1.2).animate(
      CurvedAnimation(parent: _heartController, curve: Curves.elasticOut),
    );
  }

  @override
  void dispose() {
    _heartController.dispose();
    super.dispose();
  }

  void _handleDoubleTap() {
    if (widget.onDoubleTap != null) {
      widget.onDoubleTap!();
    }
    setState(() {
      _showHeart = true;
    });
    _heartController.forward().then((_) {
      Future.delayed(const Duration(milliseconds: 200), () {
        if (mounted) {
          _heartController.reverse().then((_) {
            setState(() {
              _showHeart = false;
            });
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onDoubleTap: _handleDoubleTap,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: 400,
                  viewportFraction: 1.0,
                  enlargeCenterPage: false,
                  enableInfiniteScroll: false,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
                items: widget.images.map((url) {
                  return Builder(
                    builder: (BuildContext context) {
                      return PinchToZoomImage(url: url);
                    },
                  );
                }).toList(),
              ),
              // Big Heart Animation
              if (_showHeart)
                ScaleTransition(
                  scale: _heartAnimation,
                  child: const Icon(
                    Icons.favorite,
                    color: Colors.white,
                    size: 100,
                  ),
                ),
              if (widget.images.length > 1)
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(178),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${_currentIndex + 1}/${widget.images.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        if (widget.images.length > 1)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.images.asMap().entries.map((entry) {
                return Container(
                  width: 6.0,
                  height: 6.0,
                  margin: const EdgeInsets.symmetric(horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == entry.key
                        ? AppConstants.igBlue
                        : Colors.grey[300],
                  ),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}

class PinchToZoomImage extends StatefulWidget {
  final String url;

  const PinchToZoomImage({super.key, required this.url});

  @override
  State<PinchToZoomImage> createState() => _PinchToZoomImageState();
}

class _PinchToZoomImageState extends State<PinchToZoomImage> {
  late PhotoViewController _controller;
  double _scale = 1.0;

  @override
  void initState() {
    super.initState();
    _controller = PhotoViewController()
      ..outputStateStream.listen((event) {
        if (mounted) {
          setState(() {
            _scale = event.scale ?? 1.0;
          });
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background dimming layer
        if (_scale > 1.0)
          Positioned.fill(
            child: Container(
              color: Colors.black.withAlpha(((_scale - 1.0) * 150).clamp(0, 200).toInt()),
            ),
          ),
        ClipRect(
          child: PhotoView.customChild(
            controller: _controller,
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 2,
            initialScale: PhotoViewComputedScale.contained,
            backgroundDecoration: const BoxDecoration(color: Colors.transparent),
            child: CachedNetworkImage(
              imageUrl: widget.url,
              fit: BoxFit.cover,
              width: double.infinity,
              placeholder: (context, url) => Container(color: Colors.grey[200]),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),
      ],
    );
  }
}
