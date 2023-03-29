import 'package:boat/app/themes/AppDimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../AppColors.dart';

class AppTextStyles {
  static final h1 = GoogleFonts.poppins(
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
    color: const Color(0xff2E3E5C),
  );
  static const kPrimaryTitle = TextStyle(
    fontSize: AppDimensions.kLargeSize,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
    color: Color(0xff2E3E5C),
  );
  static const kPrimaryS2W4 = TextStyle(
      fontSize: AppDimensions.kMediumSize,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
      color: AppColors.S_text);
  static const kPrimaryS3W4 = TextStyle(
    fontSize: AppDimensions.kMediumSize,
    fontWeight: FontWeight.w700,
    color: AppColors.Primary_white,
  );
  static const kPrimaryS4W4 = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 14,
    color: AppColors.Proyel_blue,
  );
  static const ktitle =
      TextStyle(fontSize: 23, fontWeight: FontWeight.w500, color: Colors.black);
  static const kPrimaryS5W4 = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );
  static const kPrimaryS7W4 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.grey,
  );
  static const kPrimaryS7W5 = TextStyle(
    color: AppColors.title_clr,
    fontWeight: FontWeight.w700,
    fontSize: 18,
  );
  static const kPrimaryS8W5 =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black);
  static const kPrimaryS9W5 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Color(0xffFF5842),
  );
  static const kPrimaryS9W8 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );
  static const kPrimaryS9W6 = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 18,
    color: Colors.black,
  );
  static const kPrimaryS9W7 =
      TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w500);
  static const kPrimaryS10W1 = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w700,
    color: AppColors.title_clr,
  );
  static const kPrimaryS10W2 = TextStyle(
    fontWeight: FontWeight.w500,
    color: AppColors.light_clr,
    fontSize: 12,
  );
  static const kPrimaryS10W3 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );
  static const kPrimaryS10W4 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.black_type,
  );
  static const kPrimaryS11W1 = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16,
    color: Colors.white,
  );
  static const kPrimaryS11W2 = TextStyle(
    color: Color(0xff9FA5C0),
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );
  static const kPrimaryS11W4 = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w500,
    color: Color(0xff3E5481),
  );
  static const kPrimaryS11W5 = TextStyle(
    fontSize: 23,
    fontWeight: FontWeight.w600,
    color: AppColors.black_type,
  );
  static const kPrimaryS11W6 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );
  static const kPrimaryS12W1 = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: AppColors.title_clr,
  );
  static const kPrimaryS12W2 = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: Color(0xff9FA5C0),
  );
  static const Klight = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    color: AppColors.black_type,
  );
  static const weeks = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: AppColors.Proyel_blue,
  );
  static const kPrimaryS12W3 = TextStyle(
    color: AppColors.title_clr,
    fontWeight: FontWeight.w700,
    fontSize: 18,
  );
}
