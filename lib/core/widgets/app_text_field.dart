import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/Appcolor.dart';


class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.validator,
    this.inputFormat,
    this.suffixIcon,
    this.keyType = TextInputType.emailAddress,
    this.errorTextColor = AppColors.primary,
    this.fillColor = AppColors.white,
    this.isBordered = true,
    this.isObscured = false,
  });
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormat;
  final Widget? suffixIcon;
  final TextInputType keyType;
  final Color errorTextColor;
  final Color fillColor;
  final bool isBordered;
  final bool isObscured;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        validator: validator,
        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
        },
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(
              color: isBordered ? const Color(0xFF000000) : Colors.transparent,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(
              color: AppColors.black,
            ),
          ),
          fillColor: fillColor,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey.shade400,
            fontSize: 15.0,
          ),
          errorStyle: TextStyle(
            color: errorTextColor,
            fontSize: 13.0,
          ),
          suffixIcon: suffixIcon,
        ),
        style: const TextStyle(
          color: AppColors.black,
          fontWeight: FontWeight.w500,
        ),
        obscureText: isObscured,
        keyboardType: keyType,
        inputFormatters: inputFormat,
        onTap: () {
          FocusNode().requestFocus(FocusNode(canRequestFocus: true));
        });
  }
}

class CustomTextFeild extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final bool isBordered;
  final Widget? suffix;
  final void Function()? onTap;
  final bool readOnly;
  final bool autoFocus;
  final EdgeInsetsGeometry? contentPadding;
  final Color? fillColor;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final void Function(String)? onDobeButtondCompletd;

  final void Function()? onTextfiledComplete;

  final int? maxLines;
  final double? width;
  final double? height;
  final bool? showFocusBorder;
  final bool useAdjustedPadding;
  final bool isExpandedTextField;

  const CustomTextFeild({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator,
    required this.isBordered,
    this.suffix,
    this.onTap,
    this.readOnly = false,
    this.autoFocus = false,
    this.contentPadding,
    this.fillColor,
    this.keyboardType,
    this.onTextfiledComplete,
    this.onChanged,
    this.onDobeButtondCompletd,
    this.maxLines,
    this.width,
    this.height,
    this.showFocusBorder = true,
    this.useAdjustedPadding = true,
    this.isExpandedTextField = false,
  });

  static void unfocusTextField(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: isExpandedTextField ? height : height ?? 65,
      child: TextFormField(
        maxLines: maxLines,
        onEditingComplete: onTextfiledComplete,
        onChanged: onChanged,
        readOnly: readOnly,
        autofocus: autoFocus,
        onTap: onTap,
        onFieldSubmitted: onDobeButtondCompletd,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        validator: validator,
        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
        },
        decoration: InputDecoration(
            contentPadding: useAdjustedPadding
                ? const EdgeInsets.only(top: 2, left: 10)
                : contentPadding,
            // contentPadding: const EdgeInsets.symmetric(
            //   vertical: 10.0,
            //   horizontal: 15.0,
            // ),

            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(
                color:
                    isBordered ? const Color(0xFF000000) : Colors.transparent,
              ),
            ),
            errorBorder: const OutlineInputBorder(
              gapPadding: 20,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(
                color: Colors.black,
              ),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                borderSide: showFocusBorder!
                    ? const BorderSide(
                        color: Colors.black,
                      )
                    : BorderSide.none),
            fillColor: fillColor ?? Colors.grey.shade200,
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 15.0,
            ),
            errorStyle: const TextStyle(
              color: Colors.red,
              fontSize: 13.0,
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.all(2),
              child: suffix,
            )
            // prefixIcon: Padding(
            //   padding: const EdgeInsets.all(10.0),
            //   child: Row(
            //     mainAxisSize: MainAxisSize.min,
            //     children: [
            //       // Image.asset(
            //       //   'assets/india_flag.png', // Replace with the path to your image
            //       //   height: 20.0,
            //       //   width: 20.0,
            //       // ),
            //       const SizedBox(width: 8.0),
            //       const Text(
            //         '+91',
            //         style: TextStyle(
            //           color: Colors.black,
            //           fontSize: 15.0,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            ),
        style: const TextStyle(
          decorationThickness: 0,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        keyboardType: keyboardType ??
            (hintText == 'Phone no' ? TextInputType.phone : TextInputType.name),
      ),
    );
  }
}
