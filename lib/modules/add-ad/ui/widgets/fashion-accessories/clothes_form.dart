import 'package:souq_al_balad/global/components/custom_dropdown.dart';
import 'package:souq_al_balad/global/components/custom_radio_option.dart';
import 'package:souq_al_balad/global/components/text_field_app.dart';
import 'package:souq_al_balad/global/localization/app_localization.dart';
import 'package:souq_al_balad/global/utils/color_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClothesFormSection extends StatelessWidget {
  final String? condition;
  final String? city;
  final String? promotionOption;
  final Function(String?) setCondition;
  final Function(String?) setCity;
  final Function(String?) setPromotionOption;
  final VoidCallback pickImages;
  final List<String> cities;

  const ClothesFormSection({
    super.key,
    required this.condition,
    required this.city,
    required this.promotionOption,
    required this.setCondition,
    required this.setCity,
    required this.setPromotionOption,
    required this.pickImages,
    required this.cities,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          hintText: AppLocalization.of(context).translate('enter_ad_title'),
        ),
        SizedBox(height: 12.h),
        _buildRadioRow(AppLocalization.of(context).translate('condition'), [
          CustomRadioOption(
            label: AppLocalization.of(context).translate('new'),
            value: 'new',
            groupValue: condition,
            onChanged: setCondition,
          ),
          CustomRadioOption(
            label: AppLocalization.of(context).translate('used'),
            value: 'used',
            groupValue: condition,
            onChanged: setCondition,
          ),
        ]),
        SizedBox(height: 12.h),
        CustomTextField(
          hintText: AppLocalization.of(context).translate('type'),
        ),
        SizedBox(height: 12.h),
        CustomTextField(
          hintText: AppLocalization.of(context).translate('size'),
        ),
        SizedBox(height: 12.h),
        CustomTextField(
          hintText: AppLocalization.of(context).translate('brand'),
        ),
        SizedBox(height: 12.h),
        CustomTextField(
          hintText: AppLocalization.of(context).translate('color'),
        ),
        SizedBox(height: 12.h),
        CustomDropdown(
          hint: AppLocalization.of(context).translate('season'),
          value: null,
          items: [
            AppLocalization.of(context).translate('summer'),
            AppLocalization.of(context).translate('winter'),
            AppLocalization.of(context).translate('spring'),
            AppLocalization.of(context).translate('autumn'),
          ],
          onChanged: (_) {},
        ),
        SizedBox(height: 12.h),
        CustomTextField(
          hintText: AppLocalization.of(context).translate('enter_price'),
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: 12.h),
        _buildRadioRow('', [
          CustomRadioOption(
            label: AppLocalization.of(context).translate('free'),
            value: 'free',
            groupValue: condition,
            onChanged: setCondition,
          ),
          CustomRadioOption(
            label: AppLocalization.of(context).translate('negotiable'),
            value: 'negotiable',
            groupValue: condition,
            onChanged: setCondition,
          ),
          CustomRadioOption(
            label: AppLocalization.of(context).translate('not_negotiable'),
            value: 'not_negotiable',
            groupValue: condition,
            onChanged: setCondition,
          ),
        ]),
        SizedBox(height: 12.h),
        CustomDropdown(
          hint: AppLocalization.of(context).translate('choose_city'),
          value: city,
          items: cities,
          onChanged: setCity,
        ),
        SizedBox(height: 12.h),
        CustomTextField(
          hintText: AppLocalization.of(context).translate('detailed_address'),
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
              padding: EdgeInsets.only(left: 10.w, right: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocalization.of(context).translate('ad_images')),
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
          hintText: AppLocalization.of(context).translate('email_address'),
          keyboardType: TextInputType.emailAddress,
        ),
        SizedBox(height: 12.h),
        CustomTextField(
          hintText: AppLocalization.of(context).translate('description'),
          maxLines: 5,
        ),
        SizedBox(height: 12.h),
      ],
    );
  }

  Widget _buildRadioRow(String title, List<Widget> radios) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (title.isNotEmpty)
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontFamily: 'Montserrat',
              ),
            ),
          ...radios,
        ],
      ),
    );
  }
}
