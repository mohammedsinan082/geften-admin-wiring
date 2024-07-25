import 'package:flutter/material.dart';

import '../constants/Appcolor.dart';

class AppButton extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;
  final VoidCallback onTap;
  final double? width;
  final double? cornerRadius;
  final double height;
  final double fontSize;
  final IconData? icon;
  final double? iconSize;
  final FontWeight? fontWeight;
  const AppButton({
    super.key,
    required this.text,
    required this.onTap,
    this.color = AppColors.dakLightGreen,
    this.textColor = AppColors.white,
    this.height = 50,
    this.fontSize = 16,
    this.width,
    this.cornerRadius,
    this.icon,
    this.iconSize,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
        width: width,
        height: height,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            padding: EdgeInsets.all(width! * .03),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(cornerRadius ?? 8),
            ),
            elevation: 1,
          ),
          onPressed: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: TextStyle(
                    color: textColor,
                    fontSize: fontSize,
                    letterSpacing: 1,
                    fontWeight: fontWeight),
              ),
              SizedBox(width: icon != null ? 5 : 0),
              icon != null
                  ? Icon(
                      icon,
                      color: textColor,
                      size: iconSize,
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      );
}
