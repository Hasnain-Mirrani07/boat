import 'package:flutter/material.dart';

import '../../../themes/styles/textstyle.dart';

class Boating_Duration extends StatelessWidget {
  Boating_Duration(this.txt_start,this.txt_end);
String txt_start;
String txt_end;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [

                Text("Start Date",style: AppTextStyles.kPrimaryS7W4,),

                const SizedBox(height:7,),


                Text(txt_start,style: AppTextStyles.kPrimaryS8W5,),

              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [

                Text("End Time",style: AppTextStyles.kPrimaryS7W4,),

                const SizedBox(height:7,),


                Text(txt_end,style: AppTextStyles.kPrimaryS8W5,),

              ],
            ),


          ],
        ),
      ],
    );
  }
}
