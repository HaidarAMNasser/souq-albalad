import 'package:souq_al_balad/global/components/button_app.dart';
import 'package:souq_al_balad/global/components/text_field_app.dart';
import 'package:souq_al_balad/global/localization/app_localization.dart';
import 'package:souq_al_balad/global/utils/color_app.dart';
import 'package:souq_al_balad/global/utils/images_file.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpgradeToMerchantScreen extends StatefulWidget {
  const UpgradeToMerchantScreen({super.key});

  @override
  State<UpgradeToMerchantScreen> createState() =>
      _UpgradeToMerchantScreenState();
}

class _UpgradeToMerchantScreenState extends State<UpgradeToMerchantScreen> {
  final TextEditingController ownerNameController = TextEditingController();
  final TextEditingController storeNameController = TextEditingController();
  final TextEditingController logoController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Text(
          AppLocalization.of(context).translate("upgrade_to_merchant_account"),
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: InkWell(
          onTap: () => Get.back(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: const Icon(Icons.arrow_back_outlined),
          ),
        ),
        foregroundColor: AppColors.primary2,
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              CustomTextField(
                controller: ownerNameController,
                hintText: AppLocalization.of(
                  context,
                ).translate("merchant_name"),
                prefixIcon: Icons.person_outline,
              ),
              SizedBox(height: 16.h),
              CustomTextField(
                controller: storeNameController,
                hintText: AppLocalization.of(context).translate("shop_name"),
                prefixIcon: Icons.store_outlined,
              ),
              SizedBox(height: 16.h),
              CustomTextField(
                controller: addressController,
                hintText: AppLocalization.of(context).translate("address"),
                prefixIcon: Icons.location_on_outlined,
              ),
              SizedBox(height: 16.h),
              CustomTextField(
                controller: logoController,
                hintText: AppLocalization.of(context).translate("logo"),
                prefixIcon: Icons.image_outlined,
                readOnly: true,
                onTap: () {
                  // todo
                },
              ),
              SizedBox(height: 16.h),
              CustomTextField(
                controller: descriptionController,
                hintText: AppLocalization.of(context).translate("description"),
                maxLines: 3,
              ),
              SizedBox(height: 40.h),
              CustomButton(
                text: AppLocalization.of(context).translate("upgrade"),
                onPressed: () {
                  // todo upgrade api
                },
              ),
              SizedBox(height: 50.h),
            ],
          ),
        ),
      ),
    );
  }
}
