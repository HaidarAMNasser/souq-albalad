import 'package:souq_al_balad/global/utils/color_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AccountOptionItem extends StatelessWidget {
  final String text;
  final String? icon;
  final Color? iconColor;
  final Color? textColor;
  final VoidCallback? onTap;

  const AccountOptionItem({
    super.key,
    required this.text,
    this.icon,
    this.iconColor,
    this.textColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final defaultBackgroundColor =
        (isDark ? AppColors.darkCardBackground : AppColors.lightCardBackground);

    final defaultTextColor =
        textColor ??
        (isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary);

    final defaultIconColor = iconColor ?? defaultTextColor;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.h),
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: defaultBackgroundColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            icon == null
                ? const Center()
                : SvgPicture.asset(
                  icon!,
                  color: defaultIconColor,
                  width: 25.w,
                  height: 25.w,
                ),
            SizedBox(width: 15.w),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: defaultTextColor,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Icon(
                Icons.arrow_forward_ios,
                color:
                    (isDark
                        ? AppColors.darkTextPrimary
                        : AppColors.lightTextPrimary),
                size: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
