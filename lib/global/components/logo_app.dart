import 'package:flutter/material.dart';
import 'package:souq_al_balad/global/utils/images_file.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogoAppWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final String? imagePath;

  const LogoAppWidget({super.key, this.width, this.height, this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath ?? ImagesApp.logoApp,
      width: width ?? 277.w,
      height: height ?? 82.w,
      fit: BoxFit.cover,
    );
  }
}
