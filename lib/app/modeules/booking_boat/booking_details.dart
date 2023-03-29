
import 'package:boat/app/bottomapp.dart';
import 'package:boat/app/modeules/booking_boat/widget/boat_expenses.dart';
import 'package:boat/app/modeules/booking_boat/widget/boating_duration.dart';
import 'package:boat/app/modeules/bookings%20and%20favorites/favorite.dart';
import 'package:boat/app/modeules/remark_us/remark_us_screen.dart';

import 'package:boat/app/themes/AppColors.dart';
import 'package:boat/app/themes/AppDimensions.dart';
import 'package:boat/app/themes/styles/textstyle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../global_widgets/reuseable_button.dart';
import '../../models/bookings_boats.dart';
import '../../models/start_rating.dart';
import '../../themes/AppAssets.dart';
import '../bookings and favorites/controller/booking_controller.dart';
class Booking_detalis extends StatefulWidget {
var index;
var doc_Id;
var total_rating;
Booking_detalis({this.index,this.doc_Id,this.total_rating});
  @override
  State<Booking_detalis> createState() => _Booking_detalisState();
}

class _Booking_detalisState extends State<Booking_detalis> {
  Booking_request_controller service = Booking_request_controller();
  Future<List<Booking_Boats>>? boatsList;
  List<Booking_Boats>? retrievedboatsList;
  var value;
  var number;
  var rating;
  var id;
var data;
  Future<void> getdata() async {
    await FirebaseFirestore.instance.collection('boats')
        .doc(widget.doc_Id)
        .get()
        .then((doc) => {data = doc.data()})
        .catchError((error) =>
    {debugPrint("Error on get data from User"), print(error.toString())});

    value = data["rating"];
   number = data["number"];
   number = data["total_rating"];
   id = data["id"];


  }
  Future<void> _initRetrieval() async {
    boatsList = service.retrievebookingBoatdata();
    retrievedboatsList = await service.retrievebookingBoatdata();
  }

  var load = true;
  @override

  void initState() {
    _initRetrieval();
    Future.delayed(const Duration(seconds:2), () {
      setState((){
        load=false;
      }); // Prints after 1 second.
    });
      getdata();
    // TODO: implement initState
    super.initState();

  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(

            body: load==false?   FutureBuilder(
                future: boatsList,
                builder: (BuildContext context,
                    snapshot) {return ListView(
                  shrinkWrap: true,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 30,),
                          const Icon(Icons.arrow_back,color: AppColors.icon_clr,size: AppDimensions.kXLargeSize,),
                          const SizedBox(height:12,),
                          const Text("Booking Details",style: AppTextStyles.ktitle,),
                          const SizedBox(height:13,),

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
                                  child:  Text("Booking ID: ${retrievedboatsList![widget.index].booking_id!.substring(0,7)}",style: TextStyle(color: Colors.white),),
                                ),
                                Row(
                                  children:  [
                                    GestureDetector(onTap: (){

                                      Get.to(Remark_us(doc_uid: widget.doc_Id,oldvalue: value,n: number,owner_id: id,));
                                    },child: Text("Give Review",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
                                    Icon(Icons.arrow_forward_ios_outlined,color: Colors.white,size: 18,)

                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height:10,),
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child:Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(7.0),
                                  child:ClipRRect(borderRadius: BorderRadius.circular(10),child: Image.network("${retrievedboatsList?[widget.index].image}",width: 70,height: 70,fit: BoxFit.cover,)),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:  [
                                Text("${retrievedboatsList?[widget.index].boat_name}",style: AppTextStyles.kPrimaryS5W4,),
                                 Text("${retrievedboatsList?[widget.index].overview?.substring(0,14)} ",style: AppTextStyles.kPrimaryS7W4,),
                                    const SizedBox(height: 11,),
                                    StarRating(
                                      rating: widget.total_rating,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height:20,),
                          Text("Boating Duration",style:AppTextStyles.kPrimaryS7W5,),
                      SizedBox(height: 23,),
                          Boating_Duration("${retrievedboatsList?[widget.index].start_time}:00","${retrievedboatsList?[widget.index].end_time}:00"),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical:19.0),
                            child: Container(width: double.infinity,height: 1,color:Colors.black12,),
                          ),
                          const SizedBox(height:10,),

                          Text("Total Expenses",style:AppTextStyles.kPrimaryS7W5,),

                          const SizedBox(height:20,),
                          Boat_Expenses("Hours Per Day","${retrievedboatsList?[widget.index].hours_perday} Hours"),


                          Padding(
                            padding: const EdgeInsets.symmetric(vertical:10.0),
                            child: Container(width: double.infinity,height: 1,color:Colors.black12,),
                          ),

                          Boat_Expenses("Amount Paid","\$${retrievedboatsList?[widget.index].total_amount}"),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical:10.0),
                            child: Container(width: double.infinity,height: 1,color:Colors.black12,),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height/2.4,

                            child: Align(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 30.0,bottom: 20),

                                  child: Reuseable_button("Give review",Color(0xff001B48),Appassets.icon_search1,
                                          (){

                                            Get.to(Home());
                                      }),

                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ],
                ); }):Center(child: Text("Loading...",style: TextStyle(color: Colors.grey,),))
    );
  }
}

