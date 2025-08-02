import 'package:souq_al_balad/global/utils/color_app.dart';

import 'package:flutter/material.dart';

Widget textSlime({
  required String text,
  required BuildContext context,
  double? sizeFont,
  FontWeight? fontWeight,
  Color? color,
}) {
  return Text(
    text,
    style: Theme.of(context).textTheme.titleMedium!.copyWith(
      fontFamily: 'Montserrat',
      fontWeight: fontWeight ?? FontWeight.w300,
      color: color ?? AppColors.darkCardBackground,
      fontSize: sizeFont ?? 14,
    ),
  );
}
