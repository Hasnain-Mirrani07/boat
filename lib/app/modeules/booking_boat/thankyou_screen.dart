import 'package:boat/app/bottomapp.dart';
import 'package:boat/app/modeules/booking_boat/booking_details.dart';
import 'package:boat/app/modeules/remark_us/remark_us_screen.dart';
import 'package:boat/app/themes/styles/textstyle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../global_widgets/reuseable_button.dart';
import '../../themes/AppAssets.dart';
import '../../themes/AppColors.dart';
import '../../themes/AppDimensions.dart';

class Thankyou_screen extends StatefulWidget {
  Thankyou_screen({this.index,this.doc_id});
var index;
String? doc_id;

  @override
  State<Thankyou_screen> createState() => _Thankyou_screenState();
}

class _Thankyou_screenState extends State<Thankyou_screen> {
  var value;
  var number;
  var data;
  var total_rating;
  Future<void> getdata() async {
    await FirebaseFirestore.instance.collection('boats')
        .doc(widget.doc_id)
        .get()
        .then((doc) => {data = doc.data()})
        .catchError((error) =>
    {debugPrint("Error on get data from User"), print(error.toString())});

    value = data["rating"];
    number = data["numbers"];
    total_rating= data["total_rating"];


  }
  @override
  void initState() {
    getdata();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 38.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 40,),
            const Align(alignment: FractionalOffset.topLeft,child: Icon(Icons.close,color: AppColors.icon_clr,size: AppDimensions.kXLargeSize,)),
            SizedBox(height: 50,),

            Text("text19".tr,style: AppTextStyles.ktitle,),
            SizedBox(height: 11,),
            Text("text20".tr,style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500,fontSize: 14),textAlign: TextAlign.center,),
            SizedBox(height: 40,),
            Image.asset("assets/image 7.png"),
            SizedBox(height: 40,),
            Text("text21".tr,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: AppColors.black_type)),
            SizedBox(height: 11,),
            Text("text22".tr,style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500,fontSize: 11),textAlign: TextAlign.center,),
Spacer(),
        Reuseable_button("View Details",AppColors.Sdark_blue,Appassets.icon_search1,() {
          Get.to(Booking_detalis(index: widget.index,doc_Id: widget.doc_id,total_rating: total_rating,));
        }
        ),SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}
