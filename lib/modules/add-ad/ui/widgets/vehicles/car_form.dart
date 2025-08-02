import 'package:souq_al_balad/global/components/custom_dropdown.dart';
import 'package:souq_al_balad/global/components/custom_radio_option.dart';
import 'package:souq_al_balad/global/components/multi_select_dropdown.dart';
import 'package:souq_al_balad/global/components/text_field_app.dart';
import 'package:souq_al_balad/global/utils/color_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:souq_al_balad/global/localization/app_localization.dart';

class CarFormSection extends StatefulWidget {
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

  const CarFormSection({
    super.key,
    required this.condition,
    required this.gearType,
    required this.priceType,
    required this.city,
    required this.promotionOption,
    required this.setCondition,
    required this.setCity,
    required this.setPromotionOption,
    required this.pickImages,
    required this.cities,
    required this.setGearType,
    required this.setPriceType,
  });

  @override
  State<CarFormSection> createState() => _CarFormSectionState();
}

class _CarFormSectionState extends State<CarFormSection> {
  List<String> selectedItems = [];

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
            groupValue: widget.condition,
            onChanged: widget.setCondition,
          ),
          CustomRadioOption(
            label: AppLocalization.of(context).translate('used'),
            value: 'used',
            groupValue: widget.condition,
            onChanged: widget.setCondition,
          ),
        ]),
        SizedBox(height: 12.h),

        CustomTextField(
          hintText: AppLocalization.of(context).translate('type'),
        ),
        SizedBox(height: 12.h),
        CustomTextField(
          hintText: AppLocalization.of(context).translate('model'),
        ),
        SizedBox(height: 12.h),
        CustomTextField(
          hintText: AppLocalization.of(context).translate('manufacture_year'),
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: 12.h),
        CustomTextField(
          hintText: AppLocalization.of(context).translate('kilometers'),
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: 12.h),
        CustomTextField(
          hintText: AppLocalization.of(context).translate('fuel_type'),
        ),
        SizedBox(height: 12.h),

        _buildRadioRow('', [
          CustomRadioOption(
            label: AppLocalization.of(context).translate('normal'),
            value: 'normal',
            groupValue: widget.gearType,
            onChanged: widget.setGearType,
          ),
          CustomRadioOption(
            label: AppLocalization.of(context).translate('auto'),
            value: 'auto',
            groupValue: widget.gearType,
            onChanged: widget.setGearType,
          ),
          CustomRadioOption(
            label: AppLocalization.of(context).translate('semi_auto'),
            value: 'semi_auto',
            groupValue: widget.gearType,
            onChanged: widget.setGearType,
          ),
        ]),
        SizedBox(height: 12.h),

        CustomTextField(
          hintText: AppLocalization.of(context).translate('engine_capacity'),
        ),
        SizedBox(height: 12.h),
        CustomTextField(
          hintText: AppLocalization.of(context).translate('exterior_color'),
        ),
        SizedBox(height: 12.h),
        CustomDropdown(
          hint: AppLocalization.of(context).translate('number_of_doors'),
          value: null,
          items: [
            AppLocalization.of(context).translate('doors_2_3'),
            AppLocalization.of(context).translate('doors_4_5'),
            AppLocalization.of(context).translate('doors_6_7'),
            AppLocalization.of(context).translate('doors_other'),
          ],
          onChanged: (_) {},
        ),
        SizedBox(height: 12.h),

        CustomTextField(
          hintText: AppLocalization.of(context).translate('body_condition'),
        ),
        SizedBox(height: 12.h),

        MultiSelectDropdown(
          hint: AppLocalization.of(context).translate('features'),
          selectedItems: selectedItems,
          items: [
            AppLocalization.of(context).translate('air_conditioner'),
            AppLocalization.of(context).translate('leather_seats'),
            AppLocalization.of(context).translate('navigation_system'),
            AppLocalization.of(context).translate('panoramic_roof'),
            AppLocalization.of(context).translate('adaptive_cruise_control'),
            AppLocalization.of(context).translate('parking_assist'),
            AppLocalization.of(context).translate('rear_camera'),
            'Abs',
            AppLocalization.of(context).translate('bluetooth'),
            AppLocalization.of(context).translate('aluminum_rims'),
            AppLocalization.of(context).translate('heated_seats'),
            AppLocalization.of(context).translate('electric_windows'),
            AppLocalization.of(context).translate('fog_lights'),
            AppLocalization.of(context).translate('rain_sensor'),
            AppLocalization.of(context).translate('keyless_start_system'),
            AppLocalization.of(context).translate('lane_keep_assist'),
            AppLocalization.of(context).translate('blind_spot_monitor'),
            AppLocalization.of(context).translate('electric_seat_adjustment'),
          ],
          onChanged: (newSelected) {
            setState(() {
              selectedItems = newSelected;
            });
          },
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
            groupValue: widget.priceType,
            onChanged: widget.setPriceType,
          ),
          CustomRadioOption(
            label: AppLocalization.of(context).translate('negotiable'),
            value: 'negotiable',
            groupValue: widget.priceType,
            onChanged: widget.setPriceType,
          ),
          CustomRadioOption(
            label: AppLocalization.of(context).translate('not_negotiable'),
            value: 'not_negotiable',
            groupValue: widget.priceType,
            onChanged: widget.setPriceType,
          ),
        ]),
        SizedBox(height: 12.h),

        CustomDropdown(
          hint: AppLocalization.of(context).translate('select_governorate'),
          value: widget.city,
          items: widget.cities,
          onChanged: widget.setCity,
        ),
        SizedBox(height: 12.h),

        CustomTextField(
          hintText: AppLocalization.of(context).translate('detailed_address'),
        ),
        SizedBox(height: 12.h),

        GestureDetector(
          onTap: widget.pickImages,
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
          hintText: AppLocalization.of(context).translate('email'),
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
