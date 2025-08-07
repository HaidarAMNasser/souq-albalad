import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:souq_al_balad/global/utils/color_app.dart';

class SwipeImageGallery extends StatefulWidget {
  final List<String> imageUrls;

  const SwipeImageGallery({Key? key, required this.imageUrls})
      : super(key: key);

  @override
  _SwipeImageGalleryState createState() => _SwipeImageGalleryState();
}

class _SwipeImageGalleryState extends State<SwipeImageGallery> {
  late final PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 300, // Set your desired height
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.imageUrls.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: widget.imageUrls[index],
                    width: double.infinity,
                    height: 200.h,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                    errorWidget: (context, error, stackTrace) => Center(
                      child: Icon(
                        Icons.image_not_supported,
                        size: 60,
                        color: Colors.grey[400],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 8,
                    right: 8.w,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.image,
                            size: 18.sp,
                            color: Colors.black,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            "${_currentIndex + 1}/${widget.imageUrls.length}",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        SizedBox(height: 8),
        _buildIndicator(),
      ],
    );
  }

  Widget _buildIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.imageUrls.length, (index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: _currentIndex == index ? 16 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: _currentIndex == index ?AppColors.primary : Colors.grey,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}
