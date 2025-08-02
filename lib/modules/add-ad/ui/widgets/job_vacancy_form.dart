import 'package:souq_al_balad/global/components/custom_dropdown.dart';
import 'package:souq_al_balad/global/components/text_field_app.dart';
import 'package:souq_al_balad/global/utils/color_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:souq_al_balad/global/localization/app_localization.dart';

class JobVacancyFormSection extends StatelessWidget {
  final String? condition;
  final String? city;
  final Function(String?) setCity;
  final VoidCallback pickImages;
  final List<String> cities;

  const JobVacancyFormSection({
    super.key,
    required this.condition,
    required this.city,
    required this.setCity,
    required this.pickImages,
    required this.cities,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          hintText: AppLocalization.of(context).translate('job_title'),
        ),
        SizedBox(height: 12.h),
        CustomDropdown(
          hint: AppLocalization.of(context).translate('job_type'),
          value: null,
          items: [
            AppLocalization.of(context).translate('full_time'),
            AppLocalization.of(context).translate('part_time'),
            AppLocalization.of(context).translate('remote'),
            AppLocalization.of(context).translate('temporary'),
          ],
          onChanged: (_) {},
        ),
        SizedBox(height: 12.h),
        CustomDropdown(
          hint: AppLocalization.of(context).translate('work_location'),
          value: city,
          items: cities,
          onChanged: setCity,
        ),
        SizedBox(height: 12.h),
        CustomTextField(
          hintText: AppLocalization.of(context).translate('full_address'),
        ),
        SizedBox(height: 12.h),
        CustomTextField(
          hintText: AppLocalization.of(context).translate('expected_salary'),
        ),
        SizedBox(height: 12.h),
        CustomTextField(
          hintText: AppLocalization.of(
            context,
          ).translate('required_experience'),
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: 12.h),
        CustomDropdown(
          hint: AppLocalization.of(context).translate('education_level'),
          value: null,
          items: [
            AppLocalization.of(context).translate('secondary'),
            AppLocalization.of(context).translate('university'),
            AppLocalization.of(context).translate('professional'),
          ],
          onChanged: (_) {},
        ),
        SizedBox(height: 12.h),
        CustomTextField(
          hintText: AppLocalization.of(context).translate('required_skills'),
        ),
        SizedBox(height: 12.h),
        CustomTextField(
          hintText: AppLocalization.of(context).translate('working_hours'),
        ),
        SizedBox(height: 12.h),
        CustomTextField(
          hintText: AppLocalization.of(context).translate('job_start_date'),
        ),
        SizedBox(height: 12.h),
        GestureDetector(
          onTap: pickImages,
          child: Container(
            height: 75.h,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFE0E0E0)),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalization.of(
                      context,
                    ).translate('optional_attachment'),
                  ),
                  Icon(
                    Icons.cloud_upload_outlined,
                    size: 40.sp,
                    color: AppColors.grey300,
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 12.h),
        CustomTextField(
          hintText: AppLocalization.of(context).translate('phone_number'),
          keyboardType: TextInputType.phone,
        ),
        SizedBox(height: 12.h),
        CustomTextField(
          hintText: AppLocalization.of(context).translate('email'),
          keyboardType: TextInputType.emailAddress,
        ),
        SizedBox(height: 12.h),
        CustomTextField(
          hintText: AppLocalization.of(context).translate('job_details'),
          maxLines: 5,
        ),
        SizedBox(height: 12.h),
      ],
    );
  }
}
