import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../themes/AppColors.dart';
import '../themes/AppDimensions.dart';

class Back_arrow extends StatelessWidget {
  Back_arrow(this.clr);
Color clr;
  @override
  Widget build(BuildContext context) {
    return             Icon(Icons.arrow_back,color:clr,size: AppDimensions.kXLargeSize,)
    ;
  }
}
