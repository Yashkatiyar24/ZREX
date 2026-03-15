import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerPost extends StatelessWidget {
  const ShimmerPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 100,
                    height: 12,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            // Image
            Container(
              width: double.infinity,
              height: 400,
              color: Colors.white,
            ),
            // Actions
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Container(width: 24, height: 24, color: Colors.white),
                  const SizedBox(width: 16),
                  Container(width: 24, height: 24, color: Colors.white),
                  const SizedBox(width: 16),
                  Container(width: 24, height: 24, color: Colors.white),
                ],
              ),
            ),
            // Caption
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(width: 120, height: 12, color: Colors.white),
                  const SizedBox(height: 8),
                  Container(width: double.infinity, height: 12, color: Colors.white),
                  const SizedBox(height: 4),
                  Container(width: 200, height: 12, color: Colors.white),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
