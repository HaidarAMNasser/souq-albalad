import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class CategoryShimmerGrid extends StatelessWidget {

  const CategoryShimmerGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 6,
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.85,
      ),
      itemBuilder: (_, index) {
        return Shimmer(
          color: Colors.grey,
          child: Column(
            children: [
              SizedBox(
                height: 60,
                width: 60,
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 12,
                width: 50,
              ),
            ],
          ),
        );
      },
    );
  }
}
