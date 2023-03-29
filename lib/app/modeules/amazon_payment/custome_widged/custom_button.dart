import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/colors.dart';

class BlueBtn extends StatelessWidget {
  final String title;
  final Color color;
  final double Horizentalpading;
  final void Function()? onPressed;
  const BlueBtn({
    Key? key,
    required this.title,
    this.color = blueThemeColor,
    required this.onPressed,
    this.Horizentalpading = 24,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Horizentalpading.w),
      child: SizedBox(
        height: 62.h,
        width: 327,
        child: ElevatedButton(
            onPressed: onPressed,
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(color),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ))),
            child: Center(
                child: Text(
              title,
              style: GoogleFonts.yantramanav(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: white,
              ),
            ))),
      ),
    );
  }
}
