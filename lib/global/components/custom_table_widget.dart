import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTableWidget extends StatelessWidget {

  final String title;
  final String subTitle;

  const CustomTableWidget({super.key, required this.title,required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Flexible(
                child: Text(
                  subTitle,
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Divider(thickness: 1, color: const Color(0xffBBBBBC)),
        ],
      ),
    );
  }
}
