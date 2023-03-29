import 'package:boat/app/themes/AppColors.dart';
import 'package:boat/app/themes/styles/textstyle.dart';
import 'package:flutter/material.dart';

import '../../themes/AppDimensions.dart';


class Order_tracking extends StatefulWidget {
  @override
  State<Order_tracking> createState() => _Order_trackingState();
}

class _Order_trackingState extends State<Order_tracking> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50,),
                          Icon(Icons.close,color: AppColors.icon_clr,size: AppDimensions.kXLargeSize,)
               , SizedBox(height: 10,),
                      Text("Tracking",style: AppTextStyles.kPrimaryS11W6,),
             SizedBox(height: 18,),

          Container(
                  width: double.infinity,
                  height: 29,
                  decoration:  BoxDecoration(
                    color:AppColors.blue_con,
                    borderRadius: BorderRadius.circular(17),

                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: const Text("Booking ID: 123456",style: TextStyle(color: Colors.white),),
                      ),
                      Row(
                        children: const [
                          Text("Give Review",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                          Icon(Icons.arrow_forward_ios_outlined,color: Colors.white,size: 18,)

                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 76,),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:  [
                          const CircleAvatar(
                            radius: 22,
                            backgroundColor: AppColors.Sdark_blue,
                            child: Icon(Icons.done),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text("Order Placed",style: AppTextStyles.kPrimaryS5W4,),

                              SizedBox(height: 3,),
                              Text("You have place the order",style: AppTextStyles.kPrimaryS7W4,),
                              SizedBox(height: 3,),
                              Text("02/02/2022 12:00 PM ",style: AppTextStyles.kPrimaryS11W5,),

                            ],
                          ),
                            SizedBox(width: 5,)
                        ],
                      ),
                      Container(margin: EdgeInsets.only(left: 20),height: 90,width: 3,color: Color(0xffE7F0FF),)
                    ,  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:  [
                          const CircleAvatar(
                            radius: 24,
                            backgroundColor: Color(0xffD9D9D9
                            ),
                            child: Text("2",style: AppTextStyles.kPrimaryS10W4,),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text("Booking Confirmed",style: AppTextStyles.kPrimaryS5W4,),

                              SizedBox(height: 3,),
                              Text("Owner confirmed the booking",style: AppTextStyles.kPrimaryS7W4,),
                              SizedBox(height: 3,),
                              Text("Pending ",style: AppTextStyles.kPrimaryS11W5,),

                            ],
                          ),
                          SizedBox(width: 5,)
                        ],
                      ),
                      Container(margin: EdgeInsets.only(left: 20),height: 90,width: 3,color: Color(0xffE7F0FF),)
                      ,  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:  [
                          const CircleAvatar(
                            radius: 24,
                            backgroundColor: Color(0xffD9D9D9
                            ),
                            child: Text("3",style: AppTextStyles.kPrimaryS10W4,),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text("On the way",style: AppTextStyles.kPrimaryS5W4,),

                              SizedBox(height: 3,),
                              Text("Boat is on the way ",style: AppTextStyles.kPrimaryS7W4,),
                              SizedBox(height: 3,),
                              Text("Pending ",style: AppTextStyles.kPrimaryS11W5,),

                            ],
                          ),
                          SizedBox(width:53,)
                        ],
                      ),
                      Container(margin: EdgeInsets.only(left: 20),height: 90,width: 3,color: Color(0xffE7F0FF),)
                      ,  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:  [
                          const CircleAvatar(
                            radius: 24,
                            backgroundColor: Color(0xffD9D9D9
                            ),
                            child: Text("4",style: AppTextStyles.kPrimaryS10W4,),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text("Booking Completed",style: AppTextStyles.kPrimaryS5W4,),

                              SizedBox(height: 3,),
                              Text("You have completed the ride",style: AppTextStyles.kPrimaryS7W4,),
                              SizedBox(height: 3,),
                              Text("Pending ",style: AppTextStyles.kPrimaryS11W5,),

                            ],
                          ),
                          SizedBox(width: 5,)
                        ],
                      ),

                    ],
                  ),
                ),
SizedBox(height: 25,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
