import 'package:boat/app/global_widgets/back_arrow.dart';
import 'package:boat/app/global_widgets/big_divider.dart';
import 'package:boat/app/modeules/search/search_screen.dart';
import 'package:boat/app/modeules/settings/widgets/divider.dart';
import 'package:boat/app/themes/styles/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

import '../../global_widgets/reuseable_button.dart';
import '../../global_widgets/textfield.dart';
import '../../themes/AppAssets.dart';
import '../../themes/AppColors.dart';

class Search_filters extends StatefulWidget {
  @override
  State<Search_filters> createState() => _Search_filtersState();
}

class _Search_filtersState extends State<Search_filters> {
  final TextEditingController _controller = TextEditingController();

  RangeValues _currentRangeValues = const RangeValues(40, 80);
  RangeValues _currentRangeValues1 = const RangeValues(40, 80);
  bool _value = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 26,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(onTap: (){
                      Get.back();
                    },child: Back_arrow(Colors.grey)),
                    Text("Reset",style: AppTextStyles.kPrimaryS11W5,)
                  ],
                ),
              ),
              SizedBox(height:12,),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text("Filters",style: TextStyle(      fontWeight: FontWeight.w600,fontSize: 23,color: AppColors.txt_clr,  ),),
              )
              ,SizedBox(height:8,),
              Big_divider(),
          SizedBox(height:9,),
              Padding(            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                                  const Text("Categories",style: AppTextStyles.kPrimaryS7W5,),
                    const SizedBox(height:13,),
                    Textfield("All Categoreis",Appassets.icon_search1,Icons.arrow_drop_down,Colors.black,_controller),


                  ],
                ),
              ),
              SizedBox(height:25),

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 23.0),
                    child: Text(
                      "Pricing",
                      style: AppTextStyles.kPrimaryS10W1,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "0\$",
                          style: AppTextStyles.kPrimaryS11W2,
                        ),
                        Text(
                          "50000\$",
                          style: AppTextStyles.kPrimaryS11W2,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  RangeSlider(
                    values: _currentRangeValues,
                    max: 100,
                    inactiveColor: Color(0xffF4F5F7),
                    activeColor: AppColors.Sdark_blue,

                    // labels: RangeLabels(
                    //   _currentRangeValues.start.round().toString(),
                    //   _currentRangeValues.end.round().toString(),
                    // ),
                    onChanged: (RangeValues values) {
                      setState(() {
                        _currentRangeValues = values;
                      });
                    },
                  ),
              const SizedBox(
                height: 33,
              ),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 23.0),
                child: Text(
                  "Date & Time",
                  style: AppTextStyles.kPrimaryS10W1,
                ),
              ),
              const SizedBox(
                height: 15,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "3:00 PM",
                      style: AppTextStyles.kPrimaryS11W2,
                    ),
                    Text(
                      "11:30 PM",
                      style: AppTextStyles.kPrimaryS11W2,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              RangeSlider(
                values: _currentRangeValues1,
                max: 100,
                inactiveColor: Color(0xffF4F5F7),
                activeColor: AppColors.Sdark_blue,
                // labels: RangeLabels(
                //   _currentRangeValues.start.round().toString(),
                //   _currentRangeValues.end.round().toString(),
                // ),
                onChanged: (RangeValues values) {
                  setState(() {
                    _currentRangeValues1 = values;
                  });
                },
              ),
                  const SizedBox(
                    height:27,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 21.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Start Date",
                          style: TextStyle(
                              color: Color(0xff262323),
                              fontSize: 11,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          "End Time",
                          style: TextStyle(
                              color: Color(0xff262323),
                              fontSize: 11,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 21.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "15/06/2022",
                          style: TextStyle(
                              color: Color(0xff262323),
                              fontSize: 11,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          "19/06/2022",
                          style: TextStyle(
                              color: Color(0xff262323),
                              fontSize: 11,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 18),
              child: Divider_con(),
            ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 21.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Start Time",
                      style: TextStyle(
                          color: Color(0xff262323),
                          fontSize: 11,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "End Time",
                      style: TextStyle(
                          color: Color(0xff262323),
                          fontSize: 11,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 21.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "03:00 PM",
                      style: TextStyle(
                          color: Color(0xff262323),
                          fontSize: 11,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "11:00 PM",
                      style: TextStyle(
                          color: Color(0xff262323),
                          fontSize: 11,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 17),
                child: Divider_con(),
              ),
               Padding(
                 padding: EdgeInsets.symmetric(horizontal: 24),
                 child: Reuseable_button("Search",AppColors.Sdark_blue,Appassets.icon_search1,(){
Get.to(Search_screen());
                 }
                 ),
               ),
              SizedBox(height: 15,),
                ],
          ),
        ],
      ),
    );
  }
}
