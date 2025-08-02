import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:souq_al_balad/global/utils/color_app.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircularCategoryWidget extends StatelessWidget {
  final String title;
  final String imagePath;
  final bool isSelected;
  final VoidCallback onTap;
  final double size;
  final Color? selectedColor;
  final Color? unselectedColor;
  final Color? textColor;
  final double? textSize;
  final FontWeight? textWeight;

  const CircularCategoryWidget({
    super.key,
    required this.title,
    required this.imagePath,
    required this.isSelected,
    required this.onTap,
    this.size = 120,
    this.selectedColor,
    this.unselectedColor,
    this.textColor,
    this.textSize,
    this.textWeight,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final defaultSelectedColor = selectedColor ?? AppColors.primary;
    final defaultUnselectedColor =
        unselectedColor ??
        (isDark ? AppColors.darkCardBackground : AppColors.lightCardBackground);

    final defaultTextColor =
        textColor ??
        (isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary);

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            width: size.w,
            height: size.h,
            decoration: BoxDecoration(
              color: isSelected ? defaultSelectedColor : defaultUnselectedColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color:
                      isSelected
                          ? defaultSelectedColor.withOpacity(0.3)
                          : Colors.black.withOpacity(0.1),
                  blurRadius: isSelected ? 12 : 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: AnimatedScale(
                duration: const Duration(milliseconds: 200),
                scale: isSelected ? 1.1 : 1.0,
                child: SizedBox(
                  width: size * 0.6,
                  height: size * 0.6,
                  child: CachedNetworkImage(
                    imageUrl: imagePath,
                    fit: BoxFit.contain,
                    progressIndicatorBuilder: (
                      context,
                      child,
                      loadingProgress,
                    ) {
                      return const Center(child: CircularProgressIndicator());
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
            ),
          ),
          SizedBox(height: 10.h),
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: textSize ?? 16.sp,
              fontWeight:
                  isSelected
                      ? (textWeight ?? FontWeight.w600)
                      : FontWeight.w400,
              color: isSelected ? defaultSelectedColor : defaultTextColor,
            ),
            child: Text(
              title,
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
            ),
          ),
        ],
      ),
    );
  }
}
