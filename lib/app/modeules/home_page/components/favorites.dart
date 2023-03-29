import 'package:flutter/material.dart';

import '../../../themes/styles/textstyle.dart';

class Favorites_ui extends StatelessWidget {
  Favorites_ui({Key? key,this.boatprice,this.boatname,this.img});
var img;
var boatname;
var boatprice;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Padding(
          padding: const EdgeInsets.only(right: 21.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(borderRadius: BorderRadius.circular(12),child: Image.network("$img",fit: BoxFit.cover,height: 113,width: MediaQuery.of(context).size.width/2.5,),),
              SizedBox(height: 4,),
              Text("$boatname",style: AppTextStyles.kPrimaryS5W4,),
              SizedBox(height:3,),

              const Text("Nam porttitor blandi.",style: AppTextStyles.kPrimaryS7W4,),
              SizedBox(height:3,),
              Text("\$$boatprice",style: AppTextStyles.kPrimaryS8W5,),


            ],

          ),
        ),
        SizedBox(width: 25,),
      ],
    );
  }
}
