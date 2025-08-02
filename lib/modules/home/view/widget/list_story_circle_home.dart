import 'package:souq_al_balad/global/utils/images_file.dart';
import 'package:souq_al_balad/modules/home/view/widget/story_circle_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListStoryCircleHomeAlternative extends StatefulWidget {
  const ListStoryCircleHomeAlternative({super.key});

  @override
  State<ListStoryCircleHomeAlternative> createState() =>
      _ListStoryCircleHomeAlternativeState();
}

class _ListStoryCircleHomeAlternativeState
    extends State<ListStoryCircleHomeAlternative> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90.h,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Row(
          children: List.generate(10, (index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: StoryCircle(
                imagePath: ImagesApp.instagram,
                size: 90.h,
                onTap: () => print('قصة رقم ${index + 1}'),
              ),
            );
          }),
        ),
      ),
    );
  }
}
