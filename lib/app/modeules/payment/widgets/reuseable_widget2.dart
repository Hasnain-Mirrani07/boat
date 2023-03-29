import 'package:flutter/material.dart';

class Re_useable_widget2 extends StatelessWidget {
  Re_useable_widget2(this.txt,this.txt1);
  String txt;
  String txt1;


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Container(
          padding: EdgeInsets.all(13),
        //  margin: EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color:Colors.white,
            borderRadius: BorderRadius.circular(4),


          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(txt,style: TextStyle(fontSize: 11,fontWeight: FontWeight.w500,color: Color(0xff868E96
              )),),
              Text(txt1,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14,color: Color(0xff212529
              ),),)

            ],
          ),
        ),
        ),
      ],
    );
  }
}
