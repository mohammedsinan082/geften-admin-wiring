import 'package:flutter/material.dart';

import '../constants/Appcolor.dart';

class AppText extends Text {
  AppText(super.data,
      {super.key,
      TextOverflow? overflow,
      double size = 14,
      int? maxLines,
      double? height,
      TextDecoration? decoration,
      Color color = AppColors.black,
      FontWeight bold = FontWeight.w500,
      TextAlign align = TextAlign.center,
      FontStyle fontStyle = FontStyle.normal})
      : super(
            style: TextStyle(
              decoration: decoration,
              decorationColor: color,
              fontStyle: fontStyle,
              color: color,
              height: height,
              fontSize: size,
              wordSpacing: 1.5,
              fontWeight: bold,
              overflow: overflow,
            ),
            textAlign: align,
            maxLines: maxLines);
}
