import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartly/core/constants/color.dart';

Widget customButton({
  required Function() ? onPressed,
  required String text,
  double width = double.infinity
})=>
    Container(

  width: double.infinity,
  decoration: BoxDecoration(
    color: AppColor.primaryColor,
    borderRadius: BorderRadius.circular(50),
  ),
  child: MaterialButton(
    onPressed: onPressed,
    child: Text(
      text,
      style: const TextStyle(
        color: Colors.black,
      ),
    ),
  ),
);