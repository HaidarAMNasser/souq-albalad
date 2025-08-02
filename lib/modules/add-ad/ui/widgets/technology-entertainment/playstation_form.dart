import 'package:souq_al_balad/global/components/custom_dropdown.dart';
import 'package:souq_al_balad/global/components/custom_radio_option.dart';
import 'package:souq_al_balad/global/components/text_field_app.dart';
import 'package:souq_al_balad/global/utils/color_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:souq_al_balad/global/localization/app_localization.dart';

class PlaystationFormSection extends StatelessWidget {
  final String? condition;
  final String? city;
  final String? promotionOption;
  final Function(String?) setCondition;
  final Function(String?) setCity;
  final Function(String?) setPromotionOption;
  final VoidCallback pickImages;
  final List<String> cities;

  const PlaystationFormSection({
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
    final tr = AppLocalization.of(context).translate;

    return Column(
      children: [
        CustomTextField(hintText: tr('enterAdTitle')),
        SizedBox(height: 12.h),
        _buildRadioRow(tr('condition'), [
          CustomRadioOption(
            label: tr('new'),
            value: 'new',
            groupValue: condition,
            onChanged: setCondition,
          ),
          CustomRadioOption(
            label: tr('used'),
            value: 'used',
            groupValue: condition,
            onChanged: setCondition,
          ),
        ]),
        SizedBox(height: 12.h),
        CustomTextField(hintText: tr('deviceType')),
        SizedBox(height: 12.h),
        CustomTextField(hintText: tr('modelVersion')),
        SizedBox(height: 12.h),
        CustomTextField(hintText: tr('storageCapacity')),
        SizedBox(height: 12.h),
        CustomTextField(hintText: tr('numControllersAccessories')),
        SizedBox(height: 12.h),
        CustomTextField(hintText: tr('purchaseDate')),
        SizedBox(height: 12.h),
        _buildRadioRow(tr('attachedGamesAvailable'), [
          CustomRadioOption(
            label: tr('yes'),
            value: 'yes',
            groupValue: condition,
            onChanged: setCondition,
          ),
          CustomRadioOption(
            label: tr('no'),
            value: 'no',
            groupValue: condition,
            onChanged: setCondition,
          ),
        ]),
        SizedBox(height: 12.h),
        CustomTextField(
          hintText: tr('warranty'),
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: 12.h),
        CustomTextField(
          hintText: tr('enterPrice'),
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: 12.h),
        _buildRadioRow('', [
          CustomRadioOption(
            label: tr('free'),
            value: 'free',
            groupValue: condition,
            onChanged: setCondition,
          ),
          CustomRadioOption(
            label: tr('negotiable'),
            value: 'negotiable',
            groupValue: condition,
            onChanged: setCondition,
          ),
          CustomRadioOption(
            label: tr('notNegotiable'),
            value: 'not_negotiable',
            groupValue: condition,
            onChanged: setCondition,
          ),
        ]),
        SizedBox(height: 12.h),
        CustomDropdown(
          hint: tr('selectGovernorate'),
          value: city,
          items: cities,
          onChanged: setCity,
        ),
        SizedBox(height: 12.h),
        CustomTextField(hintText: tr('detailedAddress')),
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
                  Text(tr('adImages')),
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
          hintText: tr('phoneNumber'),
          keyboardType: TextInputType.phone,
        ),
        SizedBox(height: 12.h),
        CustomTextField(
          hintText: tr('emailAddress'),
          keyboardType: TextInputType.emailAddress,
        ),
        SizedBox(height: 12.h),
        CustomTextField(hintText: tr('description'), maxLines: 5),
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
