import 'package:flutter/material.dart';

void showMessage(BuildContext context,{required String text,required Color color}){
  ScaffoldMessenger.of(context).showSnackBar(

      SnackBar(
          backgroundColor: color,
          content: Text(text))
  );
}