import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:souq_al_balad/global/localization/app_localization.dart';
import 'package:souq_al_balad/global/utils/color_app.dart';

class DescriptionBox extends StatefulWidget {

  final String description;

  const DescriptionBox({super.key, required this.description});

  @override
  State<DescriptionBox> createState() => _DescriptionBoxState();
}

class _DescriptionBoxState extends State<DescriptionBox> {

  bool isExpanded = false;
  bool showSeeMore = false;
  final int maxLines = 3;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 100), _checkIfExceedsLines);
  }

  void _checkIfExceedsLines() {
    final textSpan = TextSpan(
      text: widget.description,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 14),
    );

    final tp = TextPainter(
      maxLines: maxLines,
      textAlign: TextAlign.start,
      textDirection: TextDirection.ltr,
      text: textSpan,
    )..layout(
      maxWidth: MediaQuery.of(context).size.width - 40.w,
    );

    if (tp.didExceedMaxLines) {
      setState(() {
        showSeeMore = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.only(left: 20.w, right: 20.w,top: 20.h,bottom: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.primary2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalization.of(context).translate('description'),
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 15.h),
          Text(
            widget.description,
            maxLines: isExpanded ? null : maxLines,
            overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontSize: 14,
            ),
          ),
          if (showSeeMore) ...[
            SizedBox(height: 6.h),
            Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                style: ButtonStyle(
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                  splashFactory: NoSplash.splashFactory,
                ),
                child: Text(
                  isExpanded
                      ? AppLocalization.of(context).translate('show_less')
                      : AppLocalization.of(context).translate('show_more'),
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.orange,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
