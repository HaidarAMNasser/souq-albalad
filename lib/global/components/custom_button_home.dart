import 'package:flutter/material.dart';

class CustomButtonHome extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;

  // للأيقونة
  final IconData? icon;
  final Color? iconColor;
  final double? iconSize;
  final bool iconOnRight; // true = يمين النص، false = يسار النص

  // للصورة
  final String? imagePath;
  final String? imageUrl;
  final double? imageSize;
  final bool imageOnRight; // true = يمين النص، false = يسار النص

  // تأثيرات إضافية
  final List<BoxShadow>? boxShadow;
  final BorderSide? border;

  const CustomButtonHome({
    Key? key,
    required this.text,
    this.onPressed,
    this.backgroundColor = const Color(0xFFF49719), // برتقالي افتراضي
    this.textColor = Colors.white,
    this.width,
    this.height = 50,
    this.fontSize = 20,
    this.fontWeight = FontWeight.w400,
    this.borderRadius = 25,
    this.padding = const EdgeInsets.symmetric(horizontal: 0, vertical: 0),

    // الأيقونة
    this.icon,
    this.iconColor,
    this.iconSize = 20,
    this.iconOnRight = false,

    // الصورة
    this.imagePath,
    this.imageUrl,
    this.imageSize = 24,
    this.imageOnRight = false,

    // تأثيرات
    this.boxShadow,
    this.border,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius ?? 25),
          boxShadow: boxShadow ?? [
            // BoxShadow(
            //   color: backgroundColor!.withOpacity(0.3),
            //   blurRadius: 8,
            //   offset: const Offset(0, 4),
            // ),
          ],
          border: border != null ? Border.all(
            color: border!.color,
            width: border!.width,
          ) : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: _buildContent(),
        ),
      ),
    );
  }

  List<Widget> _buildContent() {
    List<Widget> children = [];

    // النص
    Widget textWidget = Text(

      text,
      style: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: textColor,
      ),
    );

    // الأيقونة أو الصورة
    Widget? leadingWidget = _buildLeadingWidget();

    if (leadingWidget != null) {
      if (iconOnRight || imageOnRight) {
        // النص أولاً ثم الأيقونة/الصورة
        children.add(textWidget);
        children.add(const SizedBox(width: 8));
        children.add(leadingWidget);
      } else {
        // الأيقونة/الصورة أولاً ثم النص
        children.add(leadingWidget);
        children.add(const SizedBox(width: 8));
        children.add(textWidget);
      }
    } else {
      // النص فقط
      children.add(textWidget);
    }

    return children;
  }

  Widget? _buildLeadingWidget() {
    // أولوية للصورة إذا كانت موجودة
    if (imagePath != null || imageUrl != null) {
      return _buildImage();
    }

    // ثم الأيقونة
    if (icon != null) {
      return _buildIcon();
    }

    return null;
  }

  Widget _buildIcon() {
    return Icon(
      icon,
      color: iconColor ?? textColor,
      size: iconSize,
    );
  }

  Widget _buildImage() {
    Widget imageWidget;

    if (imagePath != null) {
      imageWidget = Image.asset(
        imagePath!,
        width: imageSize,
        height: imageSize,
        fit: BoxFit.cover,
      );
    } else if (imageUrl != null) {
      imageWidget = Image.network(
        imageUrl!,
        width: imageSize,
        height: imageSize,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Icon(
            Icons.image_not_supported,
            size: imageSize,
            color: textColor?.withOpacity(0.5),
          );
        },
      );
    } else {
      return Container();
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: imageWidget,
    );
  }
}
//
// // أمثلة للاستخدام
// class ButtonExamples {
//   // زر عادي
//   static Widget simpleButton() {
//     return CustomButtonHome(
//       text: 'الأقسام',
//       onPressed: () => print('تم النقر'),
//     );
//   }
//
//   // زر مع أيقونة على اليسار
//   static Widget buttonWithIcon() {
//     return CustomButton(
//       text: 'إضافة منتج',
//       icon: Icons.add,
//       iconOnRight: false, // الأيقونة على اليسار
//       onPressed: () => print('إضافة منتج'),
//     );
//   }
//
//   // زر مع أيقونة على اليمين
//   static Widget buttonWithIconRight() {
//     return CustomButton(
//       text: 'المفضلة',
//       icon: Icons.favorite,
//       iconOnRight: true, // الأيقونة على اليمين
//       backgroundColor: const Color(0xFF008081),
//       onPressed: () => print('المفضلة'),
//     );
//   }
//
//   // زر مع صورة
//   static Widget buttonWithImage() {
//     return CustomButton(
//       text: 'سيارات',
//       imagePath: 'assets/images/car_icon.png',
//       imageOnRight: false, // الصورة على اليسار
//       onPressed: () => print('سيارات'),
//     );
//   }
//
//   // زر مخصص الألوان
//   static Widget customColorButton() {
//     return CustomButton(
//       text: 'زر مخصص',
//       backgroundColor: Colors.green,
//       textColor: Colors.white,
//       icon: Icons.check,
//       borderRadius: 12,
//       height: 60,
//       fontSize: 18,
//       onPressed: () => print('زر مخصص'),
//     );
//   }
//
//   // زر بحدود
//   static Widget outlinedButton() {
//     return CustomButton(
//       text: 'زر بحدود',
//       backgroundColor: Colors.transparent,
//       textColor: const Color(0xFFF49719),
//       border: const BorderSide(
//         color: Color(0xFFF49719),
//         width: 2,
//       ),
//       boxShadow: [], // بدون ظل
//       onPressed: () => print('زر بحدود'),
//     );
//   }
//
//   // زر صغير
//   static Widget smallButton() {
//     return CustomButton(
//       text: 'حفظ',
//       width: 100,
//       height: 40,
//       fontSize: 14,
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       onPressed: () => print('حفظ'),
//     );
//   }
//
//   // زر كامل العرض
//   static Widget fullWidthButton() {
//     return CustomButton(
//       text: 'تسجيل الدخول',
//       width: double.infinity,
//       height: 56,
//       fontSize: 18,
//       onPressed: () => print('تسجيل الدخول'),
//     );
//   }
// }