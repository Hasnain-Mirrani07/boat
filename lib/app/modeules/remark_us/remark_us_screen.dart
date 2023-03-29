import 'dart:developer';
import 'dart:ffi';

import 'package:boat/app/global_widgets/reuseable_button.dart';
import 'package:boat/app/modeules/remark_us/controller.dart';
import 'package:boat/app/themes/AppAssets.dart';
import 'package:boat/app/themes/styles/textstyle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../bottomapp.dart';
import '../../themes/AppColors.dart';
import '../../themes/AppDimensions.dart';

class Remark_us extends StatefulWidget {
  Remark_us({this.oldvalue,this.n,this.doc_uid,@required this.owner_id});
  var oldvalue;
  var n;
  var doc_uid;
  var owner_id;
  @override
  State<Remark_us> createState() => _Remark_usState();
}

class _Remark_usState extends State<Remark_us> {
  int i = 0;
  var rating;
  var data;
  var r;
  var n;
  double? total_rating2;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   log(widget.oldvalue.toString());
   log(widget.n.toString());
   log(widget.doc_uid.toString());
  }
  final con=Get.put(Get_updated());
double? d;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
               Align(
                  alignment: FractionalOffset.topLeft,
                  child: GestureDetector(
                    onTap: (){
                      Get.back();
                    },
                    child: const Icon(
                      Icons.close,
                      color: AppColors.icon_clr,
                      size: AppDimensions.kXLargeSize,
                    ),
                  )),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 37,
                  ),
                  const Text("How do you like booking?",
                      style: AppTextStyles.kPrimaryS9W6),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("For boat Comfort and boat owner behaviour",
                      style: AppTextStyles.kPrimaryS7W4),
                  const SizedBox(
                    height: 22,
                  ),
                  Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      Container(
                        width: 110,
                        height: 39,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(23),
                          color:
                          con.i == 1 ? const Color(0xffF6F6FF) : AppColors.blue_con,                        ),
                        child: TextButton.icon(
                          onPressed: () {
                            con.changeStatus();
                              log("${con.i}");
                          },
                          icon:  Text(
                            "Everything",
                            style:  TextStyle(
                                color: con.i == 1 ? Colors.black : Colors.white),

                          ),
                          label:  con.i == 1
                              ? const Icon(
                            Icons.add_circle_outline_sharp,
                            color: Colors.blue,
                            size: 19,
                          )
                              : SvgPicture.asset(
                            'assets/icons/tick.svg',
                          )
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Container(
                        width: 85,
                        height: 39,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(23),
                          color:
                              con.i1 == false ? const Color(0xffF6F6FF) : AppColors.blue_con,
                        ),
                        child: TextButton.icon(
                            onPressed: () {
                           con.updatesecond();
                            },
                            icon: Text(
                              "Boat",
                              style: TextStyle(
                                  color: con.i1 == false ? Colors.black : Colors.white),
                            ),
                            label: con.i1 == false
                                ? const Icon(
                                    Icons.add_circle_outline_sharp,
                                    color: Colors.blue,
                                    size: 19,
                                  )
                                : SvgPicture.asset(
                                    'assets/icons/tick.svg',
                                  )),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 6, bottom: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(23),
                          color:
                          con.i2 == false ? const Color(0xffF6F6FF) : AppColors.blue_con,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextButton.icon(
                            onPressed: () {
                              con.updatethird();

                            },
                            icon: Text(
                              "Service",
                              style: TextStyle(
                                  color: con.i2 == false ? Colors.black : Colors.white),
                            ),
                            label:con.i2 == false
                                ? const Icon(
                              Icons.add_circle_outline_sharp,
                              color: Colors.blue,
                              size: 19,
                            )
                                : SvgPicture.asset(
                              'assets/icons/tick.svg',
                            )
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 6, bottom: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(23),
                          color:con.i3 == false ? const Color(0xffF6F6FF) : AppColors.blue_con,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextButton.icon(
                            onPressed: () {
                              con.updatefourth();

                            },
                            icon:  Text(
                              "Service",
                              style: TextStyle(
                                  color: con.i3 == false ? Colors.black : Colors.white),

                            ),
                            label: con.i3 == false
                                ? const Icon(
                              Icons.add_circle_outline_sharp,
                              color: Colors.blue,
                              size: 19,
                            )
                                : SvgPicture.asset(
                              'assets/icons/tick.svg',
                            )
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 6, bottom: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(23),
                          color:con.i4 == false ? const Color(0xffF6F6FF) : AppColors.blue_con,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextButton.icon(
                            onPressed: () {
                              con.updatefifth();
                            },
                            icon:  Text(
                              "Service",
                              style: TextStyle(
                                  color: con.i4 == false ? Colors.black : Colors.white),

                            ),
                            label:con.i4 == false
                                ? const Icon(
                              Icons.add_circle_outline_sharp,
                              color: Colors.blue,
                              size: 19,
                            )
                                : SvgPicture.asset(
                              'assets/icons/tick.svg',
                            )
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 38,
                  ),
                  const Text(
                    "Remarks for us?",
                    style: AppTextStyles.kPrimaryS9W6,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Give us rating star & write few words for better suggestion",
                    textAlign: TextAlign.center,
                    style: AppTextStyles.kPrimaryS7W4,
                  ),
                  const SizedBox(
                    height: 23,
                  ),
                  Wrap(
                    children:  [
                    RatingBar.builder(
                    initialRating: 3,
                    minRating: 1,
                    direction: Axis.horizontal,
                    itemCount: 5,

                    itemSize: 29,
                    unratedColor: Colors.blueGrey,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 6.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Color(0xffFFD913
                      ),
                      size: 22,
                    ),
                    onRatingUpdate: (ratin) {
                   setState((){
                    rating=ratin.toInt();
                   });
                 },
                  ),

                    ],
                  ),
                  const SizedBox(
                    height: 33,
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    height: 170,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: const TextField(
                      maxLines: 8,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 6),
                        hintText: 'Write few words...',
                        border: InputBorder.none,
                      ),
                    ),



                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Reuseable_button("Submit Review", AppColors.Sdark_blue,
                      Appassets.icon_search1,(){
                        var o= int.parse(rating.toInt().toString())+int.parse(widget.oldvalue.toString());
                        var k= 1+int.parse(widget.n.toInt().toString());




                        log("$o");
                        log("$k");

                        FirebaseFirestore.instance.collection('boats').doc(widget.doc_uid).update({
                          'rating': o,
                          'numbers':k,
                          'total_rating':total_rating2?.toDouble()==null ? 1:total_rating2!.toDouble(),
                        })   ;  SetOptions(merge: false);

                        Get.to(Home());
                        getdata();

                      }),

                  const SizedBox(
                    height: 14,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getdata() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    await FirebaseFirestore.instance.collection('boats')
        .doc(widget.doc_uid)
        .get()
        .then((doc) => {data = doc.data()})
        .catchError((error) =>
    {debugPrint("Error on get data from User"), print(error.toString())});

    r = data["rating"];
   n = data["numbers"];
  total_rating2= r/n;
   log(total_rating2.toString());
    FirebaseFirestore.instance.collection('boats').doc(widget.doc_uid).update({
      'total_rating':total_rating2!.toDouble(),
    })   ;  SetOptions(merge: false);
    FirebaseFirestore.instance.collection('favorites').doc(_auth.currentUser!.uid).collection('users_favorites').doc(widget.doc_uid).update({
      'total_rating':total_rating2!.toDouble(),
    })   ;  SetOptions(merge: false);
    FirebaseFirestore.instance.collection('users_boat').doc(widget.owner_id).collection('allboats').doc(widget.doc_uid).update({
      'total_rating':total_rating2!.toDouble(),
    })   ;  SetOptions(merge: false);

  }
}
