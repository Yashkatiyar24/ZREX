import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:photo_view/photo_view.dart';
import '../utils/constants.dart';

class CarouselPost extends StatefulWidget {
  final List<String> images;

  const CarouselPost({super.key, required this.images});

  @override
  State<CarouselPost> createState() => _CarouselPostState();
}

class _CarouselPostState extends State<CarouselPost> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.topRight,
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
            if (widget.images.length > 1)
              Padding(
                padding: const EdgeInsets.all(12.0),
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
