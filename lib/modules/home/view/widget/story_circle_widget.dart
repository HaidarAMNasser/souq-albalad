import 'package:souq_al_balad/global/utils/images_file.dart';
import 'package:flutter/material.dart';

class StoryCircle extends StatelessWidget {
  final String? imagePath;
  final String? imageUrl;
  final double size;
  final Color borderColor;
  final double borderWidth;
  final VoidCallback? onTap;
  final bool hasStory;
  final Widget? child;

  const StoryCircle({
    super.key,
    this.imagePath,
    this.imageUrl,
    this.size = 70,
    this.borderColor = const Color(0xFFF49719),
    this.borderWidth = 1,
    this.onTap,
    this.hasStory = true,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: size,
        height: size,
        child: CustomPaint(
          painter:
              hasStory
                  ? DashedCirclePainter(
                    color: borderColor,
                    strokeWidth: borderWidth,
                  )
                  : null,
          child: Container(
            margin: EdgeInsets.all(borderWidth),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: ClipOval(child: _buildContent()),
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (child != null) {
      return child!;
    }

    if (imagePath != null) {
      return Image.asset(
        imagePath!,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    }

    if (imageUrl != null) {
      return Image.network(
        imageUrl!,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return _buildPlaceholder();
        },
        errorBuilder: (context, error, stackTrace) {
          return _buildPlaceholder();
        },
      );
    }

    return _buildPlaceholder();
  }

  Widget _buildPlaceholder() {
    return Container(
      color: Colors.grey[200],
      child: Icon(Icons.image, color: Colors.grey[400], size: size * 0.4),
    );
  }
}

class DashedCirclePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashLength;
  final double spaceLength;

  DashedCirclePainter({
    required this.color,
    this.strokeWidth = 3,
    this.dashLength = 8,
    this.spaceLength = 4,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint =
        Paint()
          ..color = color
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.stroke;

    final double radius = size.width / 2;
    final double circumference = 2 * 3.14159 * radius;
    final double dashCount = circumference / (dashLength + spaceLength);

    for (int i = 0; i < dashCount; i++) {
      final double startAngle = (i * (dashLength + spaceLength)) / radius;
      final double endAngle = startAngle + (dashLength / radius);

      canvas.drawArc(
        Rect.fromCircle(
          center: Offset(radius, radius),
          radius: radius - strokeWidth / 2,
        ),
        startAngle,
        endAngle - startAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class StoriesRow extends StatelessWidget {
  final List<StoryData> stories;
  final double storySize;
  final EdgeInsets padding;

  const StoriesRow({
    super.key,
    required this.stories,
    this.storySize = 70,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: storySize + 20,
      padding: padding,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: stories.length,
        itemBuilder: (context, index) {
          final story = stories[index];
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: StoryCircle(
              imagePath: story.imagePath,
              imageUrl: story.imageUrl,
              size: storySize,
              hasStory: story.hasStory,
              borderColor: story.borderColor ?? const Color(0xFFF49719),
              onTap: () => story.onTap?.call(),
            ),
          );
        },
      ),
    );
  }
}

// نموذج بيانات القصة
class StoryData {
  final String? imagePath;
  final String? imageUrl;
  final bool hasStory;
  final Color? borderColor;
  final VoidCallback? onTap;

  StoryData({
    this.imagePath,
    this.imageUrl,
    this.hasStory = true,
    this.borderColor,
    this.onTap,
  });
}

// أمثلة للاستخدام
class StoryExamples {
  // قصة واحدة
  static Widget singleStory() {
    return StoryCircle(
      imagePath: ImagesApp.instagram,
      size: 80,
      onTap: () => print('تم النقر على القصة'),
    );
  }

  // قصة بصورة من الإنترنت
  static Widget networkStory() {
    return StoryCircle(
      imagePath: ImagesApp.instagram,
      size: 70,
      hasStory: true,
      onTap: () => print('فتح القصة'),
    );
  }

  // قصة بدون حدود (تم مشاهدتها)
  static Widget viewedStory() {
    return StoryCircle(
      imagePath: ImagesApp.instagram,
      size: 70,
      hasStory: false, // لا توجد حدود
      borderColor: Colors.grey,
      onTap: () => print('قصة تم مشاهدتها'),
    );
  }

  // صف من القصص
  static Widget storiesRowExample() {
    final List<StoryData> stories = [
      StoryData(
        imagePath: ImagesApp.instagram,
        hasStory: true,
        onTap: () => print('قصة 1'),
      ),
      StoryData(
        imagePath: ImagesApp.instagram,
        hasStory: true,
        onTap: () => print('قصة 2'),
      ),
      StoryData(
        imagePath: ImagesApp.instagram,
        hasStory: false, // تم المشاهدة
        borderColor: Colors.grey,
        onTap: () => print('قصة 3'),
      ),
    ];

    return StoriesRow(stories: stories, storySize: 75);
  }
}
