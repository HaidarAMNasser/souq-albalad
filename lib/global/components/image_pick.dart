import 'package:souq_al_balad/global/localization/app_localization.dart';
import 'package:souq_al_balad/global/utils/color_app.dart';
import 'package:souq_al_balad/global/utils/images_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Future<dynamic> showImageBottomSheet(
  BuildContext context,
  VoidCallback? onPressedCamera,
  VoidCallback? onPressedGallery,
) {
  return showModalBottomSheet(
    isScrollControlled: true,
    useSafeArea: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
    ),
    clipBehavior: Clip.hardEdge,
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (BuildContext context1, StateSetter setState) {
          return Container(
            clipBehavior: Clip.hardEdge,
            padding: EdgeInsets.symmetric(horizontal: 5),
            //height: 240,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(3),
                right: Radius.circular(3),
              ),
            ),
            child: ListView(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.all(24),
              children: [
                ListTile(
                  shape: Border(
                    bottom: BorderSide(width: 1, color: AppColors.grey300),
                  ),
                  onTap: onPressedGallery,
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(
                    Icons.collections_outlined,
                    color: AppColors.accent,
                    size: 30,
                  ),
                  title: Text(
                    AppLocalization.of(context).translate("from_gallery"),
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                ),
                ListTile(
                  onTap: onPressedCamera,
                  contentPadding: EdgeInsets.zero,
                  leading: SizedBox(
                    height: 30,
                    width: 30,
                    child: SvgPicture.asset(ImagesApp.camera),
                  ),
                  title: Text(
                    AppLocalization.of(context).translate("camera"),
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
