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
// Note: I've removed unused imports like AppLocalization, Svg, etc.
// Add them back if you use them elsewhere in the file.
import 'package:souq_al_balad/modules/ad-details/data/models/ad_details_model.dart'; // Your data model import

/// Builds a table to display all available product details.
///
/// This widget dynamically creates a map of details from the [productData] object.
/// It automatically hides any rows where the value is null, an empty string, or "0".
/// All labels are hardcoded in Arabic.
Widget buildProductDetailsTable(BuildContext context, ProductData productData) {
  // Use a LinkedHashMap to preserve the insertion order of details.
  final Map<String, String> infoMap = {};

  // Helper function to add a key-value pair to the map only if the value is valid.
  void addDetail(String key, String? value, {String suffix = ''}) {
    if (value != null && value.isNotEmpty && value != '0') {
      infoMap[key] = '$value$suffix';
    }
  }

  // --- Populating the details from the ProductData model ---

  // From productData.product
  final product = productData.product;
  final mainCost = productData.costs
      .firstWhere((c) => c.isMain, orElse: () => productData.costs.first);

  addDetail('السعر', product.price, suffix: ' ${mainCost.toCurrency}');
  addDetail('العنوان', product.addressDetails);

  // From productData.category and subCategory
  addDetail('الفئة', productData.category.name);
  addDetail('الفئة الفرعية', productData.subCategory.name);

  // From productData.details
  final details = productData.details;
  addDetail('الحالة', details.type);
  addDetail('الماركة (البراند)', details.brand);
  addDetail('الموديل', details.model);
  addDetail('سنة الصنع', details.yearOfManufacture);
  addDetail('اللون', details.color);
  addDetail('المسافة المقطوعة', details.kilometers, suffix: ' كم');
  addDetail('نوع الوقود', details.fuelType);
  addDetail('سعة المحرك', details.engineCapacity, suffix: ' لتر');
  addDetail('عدد الأبواب', details.numOfDoors);
  addDetail('الملكية', details.ownership);
  addDetail('الضمان', details.warranty);
  addDetail('الإكسسوارات', details.accessories);
  addDetail('المواصفات الرئيسية', details.mainSpecification);
  addDetail('الأبعاد', details.dimensions);
  addDetail('الحجم أو الوزن', details.sizeOrWeight);
  addDetail('التخزين', details.storage);
  addDetail('اللغة', details.language);
  addDetail('المؤلف', details.author);
  addDetail('سنة الإصدار (للكتب)', details.year);
  addDetail('المساحة', details.area, suffix: ' م²');
  addDetail('الطابق', details.floor);

  // If after checking all fields, there are no details to show, return an empty container.
  if (infoMap.isEmpty) {
    return SizedBox.shrink();
  }

  // --- Building the Table widget from the populated map ---
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
                fontWeight: FontWeight.bold, // Bolder for better readability
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
                color: Colors.grey[800], // Slightly darker grey
                fontFamily: 'Montserrat',
              ),
            ),
          ),
        ],
      );
    }).toList(),
  );
}
// Widget buildInfoTable(BuildContext context, ProductData productData) {
//   Map<String, String> info = {
//     AppLocalization.of(context).translate("condition"):
//         productData.details.type ?? "",
//     AppLocalization.of(context).translate("brand"):
//         productData.details.brand ?? "",
//     AppLocalization.of(context).translate("model"):
//         productData.details.model ?? "",
//     AppLocalization.of(context).translate("year"):
//         productData.details.yearOfManufacture ?? "",
//     AppLocalization.of(context).translate("mileage"):
//         "${productData.details.kilometers ?? "0"} كم",
//     AppLocalization.of(context).translate("transmission"): AppLocalization.of(
//       context,
//     ).translate("automatic"),
//     AppLocalization.of(context).translate("engine_size"):
//         "${productData.details.engineCapacity ?? "0"} لتر",
//     AppLocalization.of(context).translate("color"): AppLocalization.of(
//       context,
//     ).translate(productData.details.color ?? "غير محدد"),
//     AppLocalization.of(context).translate("doors"):
//         productData.details.numOfDoors ?? "غير محدد",
//     AppLocalization.of(context).translate("price"):
//         productData.product.price ?? "غير محدد",
//     AppLocalization.of(context).translate(
//       "body_condition",
//     ): AppLocalization.of(context).translate("no_accidents"),
//     AppLocalization.of(context).translate("email"): "example@email.com",
//   };

//   return Table(
//     columnWidths: {0: FlexColumnWidth(2), 1: FlexColumnWidth(3)},
//     children: info.entries.map((e) {
//       return TableRow(
//         children: [
//           Padding(
//             padding: EdgeInsets.symmetric(vertical: 8.h),
//             child: Text(
//               e.key,
//               style: TextStyle(
//                 fontSize: 14.sp,
//                 fontWeight: FontWeight.w700,
//                 fontFamily: 'Montserrat',
//               ),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.symmetric(vertical: 8.h),
//             child: Text(
//               e.value,
//               style: TextStyle(
//                 fontSize: 14.sp,
//                 color: Colors.grey[700],
//                 fontFamily: 'Montserrat',
//               ),
//             ),
//           ),
//         ],
//       );
//     }).toList(),
//   );
// }

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
