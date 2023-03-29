// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'utils/colors.dart';


class CustomTextField2 extends StatelessWidget {
  final String? hintText;
  final Function? onChanged;
  TextEditingController? editingController;

  CustomTextField2({
    this.hintText,
    this.onChanged,
    this.editingController,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0.h,
      width: 320,
      child: TextFormField(
        keyboardType: TextInputType.number,
        controller: editingController,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
              color: lightGreyColor),
          contentPadding:
              const EdgeInsets.only(top: 13.0, left: 22.0, right: 20),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: blac),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                width: 1, color: Color.fromARGB(255, 132, 160, 216)),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onChanged: (val) {
          onChanged;
        },
      ),
    );
  }
}
