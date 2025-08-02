import 'package:souq_al_balad/global/components/custom_dropdown.dart';
import 'package:souq_al_balad/global/components/custom_radio_option.dart';
import 'package:souq_al_balad/global/components/text_field_app.dart';
import 'package:souq_al_balad/global/utils/color_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:souq_al_balad/global/localization/app_localization.dart';

class ApartmentsFarmsFormSection extends StatelessWidget {
  final String? condition;
  final String? city;
  final String? promotionOption;
  final Function(String?) setCondition;
  final Function(String?) setCity;
  final Function(String?) setPromotionOption;
  final VoidCallback pickImages;
  final List<String> cities;
  final String? gearType;
  final String? priceType;
  final Function(String?) setGearType;
  final Function(String?) setPriceType;

  const ApartmentsFarmsFormSection({
    super.key,
    required this.condition,
    required this.city,
    required this.promotionOption,
    required this.setCondition,
    required this.setCity,
    required this.setPromotionOption,
    required this.pickImages,
    required this.cities,
    required this.gearType,
    required this.priceType,
    required this.setGearType,
    required this.setPriceType,
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
            label: AppLocalization.of(context).translate('old'),
            value: 'old',
            groupValue: condition,
            onChanged: setCondition,
          ),
        ]),
        SizedBox(height: 12.h),
        CustomTextField(
          hintText: AppLocalization.of(context).translate('property_type'),
        ),
        SizedBox(height: 12.h),
        CustomTextField(
          hintText: AppLocalization.of(context).translate('property_ownership'),
        ),
        SizedBox(height: 12.h),
        CustomTextField(
          hintText: AppLocalization.of(context).translate('contract_type'),
        ),
        SizedBox(height: 12.h),
        CustomTextField(
          hintText: AppLocalization.of(context).translate('number_of_rooms'),
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: 12.h),
        CustomTextField(
          hintText: AppLocalization.of(
            context,
          ).translate('number_of_bathrooms'),
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: 12.h),
        CustomTextField(
          hintText: AppLocalization.of(
            context,
          ).translate('number_of_balconies'),
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: 12.h),
        CustomTextField(
          hintText: AppLocalization.of(context).translate('area'),
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: 12.h),
        CustomTextField(
          hintText: AppLocalization.of(context).translate('floor'),
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: 12.h),
        _buildRadioRow('', [
          CustomRadioOption(
            label: AppLocalization.of(context).translate('furnished'),
            value: 'yes',
            groupValue: gearType,
            onChanged: setGearType,
          ),
          CustomRadioOption(
            label: AppLocalization.of(context).translate('unfurnished'),
            value: 'no',
            groupValue: gearType,
            onChanged: setGearType,
          ),
        ]),
        SizedBox(height: 12.h),
        CustomTextField(
          hintText: AppLocalization.of(context).translate('building_age'),
        ),
        SizedBox(height: 12.h),
        CustomDropdown(
          hint: AppLocalization.of(context).translate('readiness'),
          value: null,
          items: [
            AppLocalization.of(context).translate('ready'),
            AppLocalization.of(context).translate('under_construction'),
            AppLocalization.of(context).translate('needs_renovation'),
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
            groupValue: priceType,
            onChanged: setPriceType,
          ),
          CustomRadioOption(
            label: AppLocalization.of(context).translate('negotiable'),
            value: 'negotiable',
            groupValue: priceType,
            onChanged: setPriceType,
          ),
          CustomRadioOption(
            label: AppLocalization.of(context).translate('not_negotiable'),
            value: 'not_negotiable',
            groupValue: priceType,
            onChanged: setPriceType,
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
                  Text(AppLocalization.of(context).translate('ad_image')),
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
