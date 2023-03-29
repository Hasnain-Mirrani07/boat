import 'package:boat/app/themes/AppAssets.dart';
import 'package:boat/app/themes/styles/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../themes/AppColors.dart';
class Textfield extends StatelessWidget {
Textfield(@required this.label,this.icon,this.icon2,this.clr,this.controller);
  var label;
  TextEditingController controller;
  SvgPicture icon;
  IconData icon2;
  Color clr;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width/1.1,
      height: 56,
      child: TextField(
controller: controller,
        decoration: InputDecoration(
            prefixIcon:SizedBox(width: 20,height: 10,child: icon),
            suffixIcon: Icon(icon2,color:clr ,),
           hintText: label,


            hintStyle: AppTextStyles.kPrimaryS2W4,
            enabledBorder: OutlineInputBorder(

              borderSide:BorderSide(width: 1, color:AppColors.S_text),
              borderRadius: BorderRadius.circular(16),
            ),
            focusedBorder: OutlineInputBorder(

              borderSide:const BorderSide(width: 1, color:AppColors.S_text),
              borderRadius: BorderRadius.circular(16),
            ),),
      ),

    );
  }
}
class Textfield2 extends StatelessWidget {
  Textfield2(this.label, this.controller);

  var label;
  TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.1,
      height: 56,
      child: TextField(

        controller: controller,
        maxLines: 6,

        decoration: InputDecoration(

            hintText: label,
            hintStyle: AppTextStyles.kPrimaryS2W4,
            prefixIcon: Icon(Icons.search,color: Colors.grey,),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: AppColors.S_text),
              borderRadius: BorderRadius.circular(13),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: AppColors.S_text),
              borderRadius: BorderRadius.circular(13),
            )),
      ),
    );
  }
}
