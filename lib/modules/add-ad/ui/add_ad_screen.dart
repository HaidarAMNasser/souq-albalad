import 'package:souq_al_balad/global/localization/app_localization.dart';
import 'package:souq_al_balad/global/utils/color_app.dart';
import 'package:souq_al_balad/modules/add-ad/logic/add_ad_cubit.dart';
import 'package:souq_al_balad/modules/add-ad/logic/add_ad_state.dart';
import 'package:souq_al_balad/modules/add-ad/ui/widgets/exchange_form.dart';
import 'package:souq_al_balad/modules/add-ad/ui/widgets/job_vacancy_form.dart';
import 'package:souq_al_balad/modules/add-ad/ui/widgets/publish_service_form.dart';
import 'package:souq_al_balad/modules/add-ad/ui/widgets/search_job_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:souq_al_balad/global/components/custom_dropdown.dart';

class AddAdScreen extends StatelessWidget {
  const AddAdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddAdCubit(),
      child: BlocBuilder<AddAdCubit, AddAdState>(
        builder: (context, state) {
          final cubit = context.read<AddAdCubit>();

          return Scaffold(
            appBar: AppBar(
              title: Text(
                AppLocalization.of(context).translate("title_add_new_ad"),
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Montserrat',
                ),
              ),
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: AppColors.primary),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.all(16.0.w),
              child: ListView(
                children: [
                  CustomDropdown(
                    hint: AppLocalization.of(
                      context,
                    ).translate("select_ad_type"),
                    value: state.adType,
                    items: cubit.adTypes,
                    onChanged: cubit.setAdType,
                  ),
                  if (state.adType == 'إعلان لمنتج') ...[
                    SizedBox(height: 12.h),
                    CustomDropdown(
                      hint: AppLocalization.of(
                        context,
                      ).translate("select_section"),
                      value: state.section,
                      items: cubit.sections,
                      onChanged: cubit.setSection,
                    ),
                  ] else if (state.adType == 'وظيفة شاغرة') ...[
                    SizedBox(height: 12.h),
                    JobVacancyFormSection(
                      condition: state.condition,
                      city: state.city,
                      setCity: cubit.setCity,
                      pickImages: cubit.pickImages,
                      cities: cubit.cities,
                    ),
                  ] else if (state.adType == 'أنا أبحث عن عمل') ...[
                    SizedBox(height: 12.h),
                    SearchJobFormSection(
                      condition: state.condition,
                      city: state.city,
                      setCity: cubit.setCity,
                      pickImages: cubit.pickImages,
                      cities: cubit.cities,
                    ),
                  ] else if (state.adType == 'نشر خدمة') ...[
                    SizedBox(height: 12.h),
                    PublishServiceFormSection(
                      condition: state.condition,
                      city: state.city,
                      setCity: cubit.setCity,
                      pickImages: cubit.pickImages,
                      cities: cubit.cities,
                    ),
                  ] else if (state.adType == 'تبادل') ...[
                    SizedBox(height: 12.h),
                    ExchangeFormSection(
                      // condition: state.condition,
                      city: state.city,
                      setCity: cubit.setCity,
                      pickImages: cubit.pickImages,
                      cities: cubit.cities,
                    ),
                  ],
                  if (state.section != null) ...[
                    SizedBox(height: 12.h),
                    if (state.adType == 'إعلان لمنتج' &&
                        state.section != null) ...[
                      SizedBox(height: 12.h),
                      CustomDropdown(
                        hint: AppLocalization.of(
                          context,
                        ).translate("select_subsection"),
                        value: state.subSection,
                        items: cubit.getSubSections(state.section!),
                        onChanged: cubit.setSubSection,
                      ),
                    ],
                  ],
                  if (state.adType == 'إعلان لمنتج' &&
                      state.subSection != null) ...[
                    SizedBox(height: 12.h),
                    ...cubit.getDynamicFieldsForSubSection(state.subSection!),
                    SizedBox(height: 12.h),
                    Text(
                      AppLocalization.of(
                        context,
                      ).translate("paid_promotion_options"),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    SizedBox(height: 8.h),
                    ...cubit.promotionOptions.map(
                      (option) => RadioListTile<String>(
                        title: Text(option),
                        value: option,
                        groupValue: state.promotionOption,
                        onChanged: cubit.setPromotionOption,
                        activeColor: AppColors.primary,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary2,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        AppLocalization.of(context).translate("preview_ad"),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppColors.primary2, width: 2),
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        AppLocalization.of(context).translate("publish_ad"),
                        style: TextStyle(
                          color: AppColors.primary2,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
