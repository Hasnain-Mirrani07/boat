// import 'package:boat/app/modeules/home_page/controller/controller.dart';
// import 'package:boat/app/modeules/tracking_odrer/controller/get_data.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../themes/AppColors.dart';
// import '../../../themes/styles/textstyle.dart';
//
// class Ui extends StatefulWidget {
//   Ui({Key? key, required this.img,required this.boatname,required this.boatprice});
//   String img;
//   String boatname;
//   String boatprice;
//
//   @override
//   State<Ui> createState() => _UiState();
// }
//
// class _UiState extends State<Ui> {
//   final con =Get.put(GetData());
//   int i=0;
//   @override
//   Widget build(BuildContext context) {
//     return   Card(
//       shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10)),
//       child: Column(
//         children: [
//           Stack(
//             children: [
//               SizedBox(
//                 width: double.infinity,
//                 height: MediaQuery.of(context).size.height / 3.4,
//                 child: ClipRRect(
//                     borderRadius: const BorderRadius.only(
//                         topRight: Radius.circular(14),
//                         topLeft: Radius.circular(14)),
//                     child: Image.network(
//                       widget.img,
//                       fit: BoxFit.cover,
//                     )),
//               ),
//              Padding(
//                 padding: EdgeInsets.all(9.0),
//                 child: Align(
//                   alignment: Alignment.topRight,
//                   child: GestureDetector(
//                     onTap: (){
//                       setState((){
//                        i=1;
//                       });
//                       i==1 ? con.favorites(widget.boatname,widget.img,widget.boatprice,) : Text("");
//                     },
//                     child: CircleAvatar(
//                         backgroundColor: Color(0xff979797),
//                         child:i==0 ? const Icon(
//                           Icons.favorite,
//                           color: Colors.white,
//                           size: 22,
//                         ):const Icon(
//                       Icons.done,
//                       color: Colors.white,
//                       size: 22,
//                     )),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 17.0, top: 10),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                      Text(
//                      widget.boatname,
//                       style: AppTextStyles.kPrimaryS5W4,
//                     ),
//                     GestureDetector(
//                       onTap: () {},
//                       child: Container(
//                         margin: EdgeInsets.only(right: 7),
//                         decoration: BoxDecoration(
//                           color: AppColors.Sdark_blue,
//                           borderRadius: BorderRadius.circular(7.0),
//                         ),
//                         child: const Padding(
//                           padding: EdgeInsets.symmetric(
//                               horizontal: 14.0, vertical: 5),
//                           child: Center(
//                             child: Text(
//                               "Book Now",
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 10.0,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const Text(
//                   "Sea View, Premium Lifestyle ",
//                   style: AppTextStyles.kPrimaryS7W4,
//                 ),
//                 const SizedBox(
//                   height: 3,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: const [
//                         Icon(
//                           Icons.star,
//                           color: Color(0xff494AFF),
//                           size: 17,
//                         ),
//                         Icon(
//                           Icons.star,
//                           color: Color(0xff494AFF),
//                           size: 17,
//                         ),
//                         Icon(
//                           Icons.star,
//                           color: Color(0xff494AFF),
//                           size: 17,
//                         ),
//                         Icon(
//                           Icons.star,
//                           color: Color(0xff494AFF),
//                           size: 17,
//                         ),
//                         Icon(
//                           Icons.star_border,
//                           color: Colors.grey,
//                           size: 17,
//                         ),
//                         SizedBox(
//                           width: 5,
//                         ),
//                         Text(
//                           "Rating",
//                           style: AppTextStyles.kPrimaryS7W4,
//                         ),
//                       ],
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(right: 8.0),
//                       child: Row(
//                         children: [
//                           Icon(
//                             Icons.person,
//                             size: 17,
//                             color: Colors.grey,
//                           ),
//                           Text(
//                             "18",
//                             style: AppTextStyles.kPrimaryS7W4,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 7,
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: 25,),
//         ],
//       ),
//     );
//   }
// }
