import 'package:flutter/material.dart';

import '../../../themes/AppColors.dart';
import '../../../themes/styles/textstyle.dart';

class Boat_Expenses extends StatelessWidget {
Boat_Expenses(this.txt1,this.txt2);String txt1;
  String txt2;

  @override
  Widget build(BuildContext context) {
    return        Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(txt1,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 14,color: AppColors.txt_clr),),
          Text(txt2,style: AppTextStyles.kPrimaryS8W5,),
        ]

    );
  }
}
