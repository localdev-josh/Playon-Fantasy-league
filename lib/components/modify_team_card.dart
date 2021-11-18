// import 'package:bordered_text/bordered_text.dart';
// import 'package:flutter/material.dart';
// import 'package:playon/components/custom_rect_tween.dart';
// import 'package:playon/components/splash_tap.dart';
// import 'package:playon/data/models/teams_model/teams.dart';
// import 'package:playon/utilities/app_colors.dart';
// import 'package:playon/utilities/app_margin.dart';
// import 'package:playon/utilities/app_strings.dart';
// import 'package:provider/provider.dart';
// import '../global_auth.dart';
//
//
// class DeleteFoodItemCard extends StatelessWidget {
//   final Teams orderItem;
//   const DeleteFoodItemCard({Key key, this.orderItem}) : super(key: key);
//
//
//   @override
//   Widget build(BuildContext context) {
//     ABSCartViewModel cartViewModel = Provider.of(context);
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(32.0),
//         child: Hero(
//           tag: '${orderItem.id}',
//           createRectTween: (begin, end) {
//             return CustomRectTween(begin: begin, end: end);
//           },
//           child: Material(
//             color: AppColors.kWhite,
//             elevation: 2,
//             shape:
//             RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 0),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     YMargin(25),
//                     BorderedText(
//                         strokeWidth: 0.1,
//                         strokeColor: AppColors.kBlack.withOpacity(0.8),
//                         child: Text(
//                           'Remove order!',
//                           textScaleFactor: 1,
//                           textAlign: TextAlign.start,
//                           style: TextStyle(
//                             decoration: TextDecoration.none,
//                             decorationColor: AppColors.kBlack.withOpacity(0.8),
//                             color: AppColors.kBlack.withOpacity(0.8),
//                             fontSize: 18,
//                             letterSpacing: -0.6,
//                             fontFamily: AppStrings.dmBold,
//                           ),
//                         )),
//                     YMargin(13),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                       child: Text(
//                         '${orderItem.title} will be remove from your cart',
//                         textScaleFactor: 1,
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           color: Color(0xff858282),
//                           fontSize: 14.1,
//                           letterSpacing: -0.4,
//                           height: 1.65,
//                           fontFamily: AppStrings.dmRegular,
//                         ),
//                       ),
//                     ),
//                     YMargin(25),
//                     Container(
//                       height: 1.5,
//                         color: Color(0xffF4F4F4)
//                     ),
//                     Container(
//                       color: Colors.transparent,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Expanded(
//                             child: Splash(
//                               onTap: () => Navigator.pop(context),
//                               splashColor: AppColors.kGreyText2,
//                               maxRadius: 25,
//                               minRadius: 15,
//                               child: Container(
//                                 height: 50,
//                                 decoration: BoxDecoration(
//                                   color: Colors.transparent,
//                                   border: Border(
//                                     right: BorderSide(color: Color(0xffF4F4F4), width: 1.5)
//                                   )
//                                 ),
//                                 child: Transform.translate(
//                                   offset: Offset(0, -3),
//                                   child: Center(
//                                     child: Text(
//                                       'Cancel',
//                                       textScaleFactor: 1,
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(
//                                         color: Color(0xff858282),
//                                         fontSize: 14.1,
//                                         letterSpacing: -0.4,
//                                         height: 1.65,
//                                         fontFamily: AppStrings.dmRegular,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Expanded(
//                             child: Splash(
//                               onTap: () {
//                                 Navigator.pop(context);
//                                 cartViewModel.removeFromList(orderItem);
//                               },
//                               splashColor: AppColors.kGreyText2,
//                               maxRadius: 25,
//                               minRadius: 15,
//                               child: Container(
//                                 height: 50,
//                                 decoration: BoxDecoration(
//                                     color: Colors.transparent,
//                                     border: Border(
//                                         right: BorderSide(color: Color(0xffF4F4F4), width: 1.5)
//                                     )
//                                 ),
//                                 child: Transform.translate(
//                                   offset: Offset(0, -3),
//                                   child: Center(
//                                     child: Text(
//                                       'Remove order',
//                                       textScaleFactor: 1,
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(
//                                         color: AppColors.kRed2,
//                                         fontSize: 14.5,
//                                         letterSpacing: -0.4,
//                                         height: 1.65,
//                                         fontFamily: AppStrings.dmBold,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }