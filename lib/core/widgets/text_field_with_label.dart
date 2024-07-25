import 'package:flutter/material.dart';

import 'app_text.dart';
import 'app_text_field.dart';

class LabelAndForm extends StatelessWidget {
  LabelAndForm(
      {Key? key,
      this.controller,
      required this.title,
      this.label,
      this.widget,
      this.suffixIcon,
      this.textInputType,
      this.onChange,
      this.fillColor,
      this.validator,
      this.height = 60,
      this.mxline = 1})
      : super(key: key);

  final TextEditingController? controller;
  final String title;
  double? height;
  final String? label;
  int? mxline;
  final Widget? widget;
  TextInputType? textInputType = TextInputType.name;
  final IconData? suffixIcon;
  final Color? fillColor;
  final void Function(String)? onChange;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        AppText(title, size: 18),
        const SizedBox(height: 10),
        widget != null
            ? widget!
            : CustomTextFeild(
                maxLines: mxline,
                useAdjustedPadding: false,
                height: height,
                validator: validator,
                fillColor: fillColor,
                keyboardType: textInputType,
                onChanged: onChange,
                controller: controller!,
                hintText: label != null ? label! : title,
                isBordered: false,
                suffix: Icon(suffixIcon),
              )
      ],
    );
  }
}
