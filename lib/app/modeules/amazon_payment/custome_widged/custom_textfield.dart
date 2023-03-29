// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/colors.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final Function? onChanged;
  final bool? ismatch;
  TextEditingController? editingController;

  CustomTextField({
    this.hintText,
    this.onChanged,
    this.ismatch,
    this.editingController,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44.0.h,
      width: 285,
      child: TextFormField(
        style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: ismatch != true ? blackTheme : Colors.green),
        controller: editingController,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: lightGreyColor),
          contentPadding: const EdgeInsets.only(
            left: 20.0,
          ),
          // enabledBorder: OutlineInputBorder(
          //   borderSide: const BorderSide(width: 1, color: blac),
          //   borderRadius: BorderRadius.circular(10),
          // ),
          // focusedBorder: OutlineInputBorder(
          //   borderSide: const BorderSide(
          //       width: 1, color: Color.fromARGB(255, 132, 160, 216)),
          //   borderRadius: BorderRadius.circular(10),
          // ),
        ),
        onChanged: (val) {
          onChanged!(val);
        },
      ),
    );
  }
}
