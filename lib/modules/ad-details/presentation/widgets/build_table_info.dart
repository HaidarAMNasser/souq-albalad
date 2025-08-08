import 'package:souq_al_balad/global/localization/app_localization.dart';
import 'package:souq_al_balad/global/utils/images_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souq_al_balad/modules/ad-details/data/models/ad_details_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:souq_al_balad/global/utils/color_app.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:souq_al_balad/modules/ad-details/data/models/ad_details_model.dart';

Widget buildProductDetailsTable(BuildContext context, ProductData productData) {
  final Map<String, String> infoMap = {};

  void addDetail(String key, String? value, {String suffix = ''}) {
    if (value != null && value.isNotEmpty && value != '0') {
      infoMap[key] = '$value$suffix';
    }
  }
 final product = productData.product;
  final mainCost = productData.costs
      .firstWhere((c) => c.isMain, orElse: () => productData.costs.first);

  String tr(String key) => AppLocalization.of(context).translate(key);

  addDetail(tr('price'), product.price, suffix: ' ${mainCost.toCurrency}');
  addDetail(tr('address'), product.addressDetails);

  addDetail(tr('category'), productData.category.name);
  addDetail(tr('sub_category'), productData.subCategory.name);

  final details = productData.details;
  addDetail(tr('condition'), details.type);
  addDetail(tr('brand'), details.brand);
  addDetail(tr('model'), details.model);
  addDetail(tr('year_of_manufacture'), details.yearOfManufacture);
  addDetail(tr('color'), details.color);
  addDetail(tr('mileage'), details.kilometers, suffix: ' km');
  addDetail(tr('fuel_type'), details.fuelType);
  addDetail(tr('engine_capacity'), details.engineCapacity, suffix: ' L'); 
  addDetail(tr('num_of_doors'), details.numOfDoors);
  addDetail(tr('ownership'), details.ownership);
  addDetail(tr('warranty'), details.warranty);
  addDetail(tr('accessories'), details.accessories);
  addDetail(tr('main_specifications'), details.mainSpecification);
  addDetail(tr('dimensions'), details.dimensions);
  addDetail(tr('size_or_weight'), details.sizeOrWeight);
  addDetail(tr('storage'), details.storage);
  addDetail(tr('language'), details.language);
  addDetail(tr('author'), details.author);
  addDetail(tr('publication_year_books'), details.year);
  addDetail(tr('area'), details.area, suffix: ' m²');
  addDetail(tr('floor'), details.floor);

  if (infoMap.isEmpty) {
    return SizedBox.shrink();
  }

  return Table(
    columnWidths: const {
      0: FlexColumnWidth(2), // Width for the key (label)
      1: FlexColumnWidth(3), // Width for the value
    },
    border: TableBorder(
      horizontalInside: BorderSide(
        color: Colors.grey.shade300,
        width: 1.0,
      ),
    ),
    children: infoMap.entries.map((entry) {
      return TableRow(
        children: [
          // Key (Label) Cell
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
            child: Text(
              entry.key,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
                color: Colors.black87,
              ),
            ),
          ),
          // Value Cell
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
            child: Text(
              entry.value,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[800], 
                fontFamily: 'Montserrat',
              ),
            ),
          ),
        ],
      );
    }).toList(),
  );
}

Widget buildFeatures(BuildContext context) {
  final features = [
    AppLocalization.of(context).translate("air_conditioning"),
    AppLocalization.of(context).translate("parking_assist"),
    AppLocalization.of(context).translate("leather_handles"),
    AppLocalization.of(context).translate("heated_seats"),
    AppLocalization.of(context).translate("sunroof"),
    AppLocalization.of(context).translate("adaptive_cruise"),
  ];

  return Wrap(
    spacing: 10.w,
    runSpacing: 6.h,
    children: features.map((f) {
      return Chip(
        label: Text(
          f,
          style: TextStyle(fontSize: 12.sp, fontFamily: 'Montserrat'),
        ),
        avatar: Icon(
          Icons.check_circle,
          color: AppColors.success,
          size: 16.sp,
        ),
      );
    }).toList(),
  );
}
