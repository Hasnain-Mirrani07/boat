import 'package:boat/app/modeules/settings/widgets/divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../themes/styles/textstyle.dart';

class Reuseable_widget extends StatelessWidget {
  Reuseable_widget(this.txt1,this.txt2,this.icon);
String txt1;
String txt2;
String icon;


  @override
  Widget build(BuildContext context) {
    return   Column(
      children: [
        ListTile(
          leading: SvgPicture.asset("assets/icons/$icon.svg"),
          title: Text(txt1,style: AppTextStyles.kPrimaryS7W4,),
          subtitle: Text(txt2,style: AppTextStyles.kPrimaryS8W5,),



        ),
        Divider_con(),
      ],
    );
  }
}
