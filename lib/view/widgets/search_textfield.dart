// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
//
// import '../../constant/app_colors.dart';
//
//
// class SearchTextField extends StatelessWidget {
//     SearchTextField({super.key, required this.hintText,required this.searchController});
// final String hintText;
// TextEditingController searchController=TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller:searchController,
//       decoration: InputDecoration(
//           contentPadding:const EdgeInsets.only(left:14,right:10,top:6,bottom:6),
//           hintText:hintText,
//           hintStyle: const TextStyle(
//               fontSize: 14,
//               color:kGreyColor,
//               fontWeight: FontWeight.w500),
//           enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide: BorderSide(color:kBorderColor)),
//           focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide: BorderSide(color: kPrimaryColor)),
//           fillColor: kWhiteColor,
//           filled: true,
//           suffixIcon:Padding(
//             padding: const EdgeInsets.only(right:6.0,top:6,bottom:6,left:6),
//             child: InkWell(
//               onTap:(){},
//               child: Container(
//                 height:35,
//                 width:35,
//                 decoration:BoxDecoration(
//                   color:kPrimaryColor,
//                   borderRadius:BorderRadius.circular(8),
//
//                 ),
//                 child:Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: SvgPicture.asset(Assets.iconsSearchIcon,),
//                 ),
//               ),
//             ),
//           )
//       ),
//
//     );
//   }
// }
