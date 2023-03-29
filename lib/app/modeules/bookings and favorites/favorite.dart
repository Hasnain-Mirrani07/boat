import 'package:boat/app/bottomapp.dart';
import 'package:boat/app/models/start_rating.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../services/uid.dart';

import '../../themes/styles/textstyle.dart';

class Favorite_page extends StatelessWidget {
  final getUid=Get.put(Uid());
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,


      body:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Padding(
            padding: EdgeInsets.only(left: 29.0,top: 50),
            child: Text("text17".tr,style: AppTextStyles.ktitle,),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('favorites').doc("${_auth.currentUser?.uid}").collection('users_favorites').snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }
if(snapshot==null){
  return Center(child:  Text("No data Available"));

}
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator())
;          }
                if(snapshot.data?.size==0){
                  return Center(child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/no_results.png',width: 110,height: 110,fit: BoxFit.cover,),
                    SizedBox(height: 10,),
                      GestureDetector(onTap: (){
                        Get.to(Home())
;                      },child: Text("Add Favorites",style: TextStyle(color: Colors.blue,fontSize: 16),))
                    ],
                  ));
                }
                return ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                    return   Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              const SizedBox(height:30,),
                              Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child:Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(7.0),
                                      child:ClipRRect(borderRadius: BorderRadius.circular(10),child: Image.network("${data['fimage']}",height: 76,width:80,fit: BoxFit.cover,)),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children:  [
                                        SizedBox(
                                          width: MediaQuery.of(context).size.width/1.8,

                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [

                                              Text(data['fboat_name'],style: AppTextStyles.kPrimaryS5W4,),
                                              SizedBox(width: 90,),
                                             Text("\$${data['fboat_price']}",style: AppTextStyles.kPrimaryS5W4,),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 4),

                                         Text("${data['foverview'].toString().substring(0,12)}",style: AppTextStyles.kPrimaryS7W4,),
                                        const SizedBox(height: 6,),

                                      StarRating(rating: data['total_rating'],)

                                      ],
                                    ),
                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    
    );
  }
}
