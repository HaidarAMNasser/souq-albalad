import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SimpleCategoryItem extends StatelessWidget {
  final String title;
  final String imageUrl;
  final VoidCallback? onTap;

  const SimpleCategoryItem({
    Key? key,
    required this.title,
    required this.imageUrl,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: onTap,
      onTap: onTap,
      child: Container(
        width: 150.h,
        height: 200.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            // الصورة
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.contain,
                  progressIndicatorBuilder: (context, child, loadingProgress) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                  errorWidget: (context, error, stackTrace) {
                    return Icon(
                      Icons.image_not_supported,
                      size: 60,
                      color: Colors.grey[400],
                    );
                  },
                ),
              ),
            ),

            // النص
            Expanded(
              flex: 2,
              child: Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
