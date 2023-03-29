import 'package:flutter/material.dart';

import '../../../themes/styles/textstyle.dart';


class Features extends StatelessWidget {
  Features(this.txt);
String txt;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(txt,style: AppTextStyles.kPrimaryS10W4,),
    );
  }
}
