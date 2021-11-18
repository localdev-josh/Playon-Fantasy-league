// import 'package:bordered_text/bordered_text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:playon/data/models/teams_model/teams.dart';
// import 'package:playon/components/splash_tap.dart';
// import 'package:playon/utilities/app_colors.dart';
// import 'package:playon/utilities/app_margin.dart';
// import 'package:playon/utilities/app_strings.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
//
//
// /// It returns [true] if the action-type was 'adding to cart', otherwise [false]
// typedef actionCallback = Function(bool actionType);
// class AddFoodOrder extends StatefulWidget {
//   final Teams foodItem;
//   final actionCallback onNext;
//
//   const AddFoodOrder({Key key, this.foodItem, this.onNext})
//       : super(key: key);
//
//   @override
//   _AddFoodOrderState createState() => _AddFoodOrderState();
// }
//
// class _AddFoodOrderState extends State<AddFoodOrder> {
//   var thousandFormatter = NumberFormat("#,##0.00", "en_US");
//   int foodCounter;
//   bool showDeleteButton = false;
//
//   incrementFoodCounter() {
//     setState(() {
//       foodCounter = foodCounter + 1;
//     });
//   }
//
//   decrementFoodCounter() {
//     if(foodCounter == 1) {
//       setState(() {
//         foodCounter = 1;
//       });
//     } else {
//       setState(() {
//         foodCounter = foodCounter - 1;
//       });
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // ABSCartViewModel cartViewModel = Provider.of(context);
//     return IntrinsicHeight(
//       child: Container(
//         color: Colors.transparent,
//         constraints: BoxConstraints(
//           minHeight: 100,
//         ),
//         child: Column(
//           children: [
//             Center(
//               child: Container(
//                 width: 30,
//                 height: 5,
//                 decoration: BoxDecoration(
//                     color: Colors.white, borderRadius: BorderRadius.circular(5)),
//               ),
//             ),
//             YMargin(10),
//             Expanded(
//               child: Container(
//                 width: double.infinity,
//                 padding: EdgeInsets.only(bottom: 30),
//                 decoration: BoxDecoration(
//                   color: AppColors.kSecondaryColor,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(10),
//                     topRight: Radius.circular(10),
//                   ),
//                 ),
//                 child: Stack(
//                   children: [
//                     Container(
//                       color: Colors.transparent,
//                       width: MediaQuery.of(context).size.width,
//                       child: Column(
//                         children: [
//                           Expanded(
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Expanded(
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       YMargin(25),
//                                       Container(
//                                         margin: EdgeInsets.only(left: 17),
//                                         decoration:  BoxDecoration(
//                                             shape: BoxShape.circle,
//                                           color: Colors.transparent,
//                                           border: Border.all(
//                                               color: AppColors.kWhite.withOpacity(0.7)
//                                           ),
//                                         ),
//                                         child: IntrinsicWidth(
//                                           child: Splash(
//                                             onTap: () {
//                                               HapticFeedback.lightImpact();
//                                               Navigator.pop(context);
//                                             },
//                                             splashColor: AppColors.kWhite,
//                                             maxRadius: 25,
//                                             minRadius: 20,
//                                             // borderRadius: BorderRadius.circular(100),
//                                             child: Container(
//                                               decoration:  BoxDecoration(
//                                                 shape: BoxShape.circle,
//                                                 border: Border.all(
//                                                     color: AppColors.kWhite.withOpacity(0.5)
//                                                 ),
//                                               ),
//                                               height: 25,
//                                               width: 25,
//                                               child: Icon(Icons.close, size: 20, color: Colors.white.withOpacity(0.4),),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       YMargin(22),
//                                       Padding(
//                                         padding: const EdgeInsets.only(left: 17, bottom: 7),
//                                         child: Row(
//                                           mainAxisAlignment: MainAxisAlignment.start,
//                                           children: [
//                                             FittedBox(
//                                               fit: BoxFit.contain,
//                                               child: RatingBar.builder(
//                                                 initialRating: 4.0,
//                                                 minRating: 1,
//                                                 direction: Axis.horizontal,
//                                                 allowHalfRating: true,
//                                                 tapOnlyMode: false,
//                                                 updateOnDrag: false,
//                                                 ignoreGestures: true,
//                                                 maxRating: 5.0,
//                                                 itemCount: 5,
//                                                 itemSize: 14,
//                                                 unratedColor: Color(0xffECF0F1),
//                                                 itemPadding: EdgeInsets.only(right: 3.0),
//                                                 itemBuilder: (context, _) => Icon(
//                                                     Icons.star,
//                                                     color: Color(0xffFFC924)
//                                                 ),
//                                                 onRatingUpdate: (rating) {
//                                                   print(rating);
//                                                 },
//                                               ),
//                                             ),
//                                             XMargin(5),
//                                           ],
//                                         ),
//                                       ),
//                                       Container(
//                                         padding: const EdgeInsets.only(left: 17, bottom: 7),
//                                         color: Colors.transparent,
//                                         child: BorderedText(
//                                             strokeWidth: 0.4,
//                                             strokeColor: AppColors.kWhite,
//                                             child: Text(
//                                               '${widget.foodItem.title}',
//                                               textScaleFactor: 1,
//                                               textAlign: TextAlign.start,
//                                               style: TextStyle(
//                                                 decoration: TextDecoration.none,
//                                                 decorationColor: AppColors.kWhite,
//                                                 color: AppColors.kWhite,
//                                                 fontSize: 22,
//                                                 letterSpacing: -0.5,
//                                                 fontFamily: AppStrings.dmBold,
//                                               ),
//                                             ))
//                                       ),
//                                       Padding(
//                                         padding: const EdgeInsets.only(left: 17, bottom: 7),
//                                         child: Row(
//                                           children: [
//                                             Text("${AppStrings.nairaSymbol}",
//                                               textScaleFactor: 1,
//                                               maxLines: 1,
//                                               overflow: TextOverflow.ellipsis,
//                                               style: TextStyle(
//                                                 fontFamily: AppStrings.dmMedium,
//                                                 color: Color(0xffffffff).withOpacity(0.5),
//                                                 fontSize: 12,
//                                                 letterSpacing: -0.2,
//                                               ),
//                                             ),
//                                             widget.foodItem.productPrice.split(".").last.contains("00") ?
//                                             Text("${thousandFormatter.format(num.tryParse(widget.foodItem.productPrice)).split(".").first}",
//                                               textScaleFactor: 1,
//                                               maxLines: 1,
//                                               overflow: TextOverflow.ellipsis,
//                                               style: TextStyle(
//                                                 fontFamily: AppStrings.dmBold,
//                                                 color: Color(0xffffffff).withOpacity(0.5),
//                                                 fontSize: 14,
//                                                 letterSpacing: -0.2,
//                                               ),
//                                             ) : Text("${thousandFormatter.format(num.tryParse(widget.foodItem.productPrice))}",
//                                               textScaleFactor: 1,
//                                               maxLines: 1,
//                                               overflow: TextOverflow.ellipsis,
//                                               style: TextStyle(
//                                                 fontFamily: AppStrings.dmBold,
//                                                 color: Color(0xffffffff).withOpacity(0.5),
//                                                 fontSize: 14,
//                                                 letterSpacing: -0.2,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Container(color: Colors.transparent,
//                                     width: 150,
//
//                                     alignment: Alignment.topCenter,
//                                     child: Stack(
//                                       children: [
//                                         Positioned(
//                                             width: 100,
//                                             height: 100,
//                                             top:25,
//                                             right: 20,
//                                             child: ClipRRect(
//                                               borderRadius: BorderRadius.circular(9),
//                                               child: CachedNetworkImage(
//                                                 height: 50,
//                                                 width: 50,
//                                                 imageUrl: "${widget.foodItem.foodUrl}",
//                                                 placeholder: (context, url) => Align(
//                                                     alignment: Alignment.center,
//                                                     child: Container(
//                                                       padding: EdgeInsets.all(8),
//                                                       color: Color(0xffF1F1F1),
//                                                       // child: Opacity( opacity: 0.9,child: Image.asset(AppStrings.appLogoWhite))
//                                                     )
//                                                 ),
//                                                 errorWidget: (context, url, error) => Icon(Icons.error),
//                                                 fit: BoxFit.cover,
//                                               ),
//                                             ),)
//                                             // child: Image.asset("assets/images/fast-food.svg", width: 70, height: 70,))
//                                       ],
//                                     ))
//                               ],
//                             ),
//                           ),
//                           Row(
//                             children: [
//                               IntrinsicWidth(
//                                 child: Container(
//                                   height: 48,
//                                   width: 150,
//                                   color: Colors.transparent,
//                                   margin: EdgeInsets.only(top: 30, left: 17),
//                                   padding: EdgeInsets.all(0),
//                                   alignment: Alignment.centerLeft,
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     crossAxisAlignment: CrossAxisAlignment.center,
//                                     children: [
//                                       Expanded(
//                                         flex: 1,
//                                         child: Container(
//                                           height: 48,
//                                           alignment: Alignment.centerLeft,
//                                           decoration: BoxDecoration(
//                                               color: Colors.transparent,
//                                               border: Border.all(color: Color(0xffDDDDDD).withOpacity(0.4), width: 0.7),
//                                               borderRadius: BorderRadius.circular(5)
//                                           ),
//                                           child: Row(
//                                             children: [
//                                               Expanded(
//                                                 child: Splash(
//                                                   onTap: () {
//                                                     if(foodCounter >=1) {
//                                                       if(foodCounter == 1) {
//                                                       } else {
//                                                         decrementFoodCounter();
//                                                       }
//                                                     } else {}
//                                                   },
//                                                   splashColor: foodCounter == 1 ? Colors.transparent : AppColors.kWhite,
//                                                   maxRadius: 20,
//                                                   minRadius: 10,
//                                                   child: Hero(
//                                                     tag: '${widget.foodItem.id}',
//                                                     child: Container(
//                                                       color: Colors.transparent,
//                                                       height: 40,
//                                                       padding: EdgeInsets.only(left: 5),
//                                                       child: Icon(
//                                                         foodCounter == 1 && widget.foodItem.controlCart ? Icons.delete : Icons.remove,
//                                                         color: foodCounter > 1 ? Colors.white: Color(0xffDDDDDD).withOpacity(0.4),
//                                                         size: 17,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                               Expanded(
//                                                   child: Align(
//                                                     alignment: Alignment.center,
//                                                     child: Text(foodCounter >=1 ?
//                                                     "$foodCounter" : "0",
//                                                       textScaleFactor: 0.81,
//                                                       style: TextStyle(
//                                                           fontFamily: AppStrings.dmRegular,
//                                                           fontWeight: FontWeight.w600,
//                                                           color: AppColors.kWhite.withOpacity(0.8),
//                                                           fontSize: 20),
//                                                     ),
//                                                   )
//                                               ),
//                                               Expanded(
//                                                 child: Splash(
//                                                   onTap: () {
//                                                     incrementFoodCounter();
//                                                   },
//                                                   splashColor: AppColors.kWhite,
//                                                   maxRadius: 20,
//                                                   minRadius: 10,
//                                                   child: Container(
//                                                     color: Colors.transparent,
//                                                     height: 40,
//                                                     padding: EdgeInsets.only(right: 5),
//                                                     child: Icon(
//                                                       Icons.add,
//                                                       color: Colors.white,
//                                                       size: 17,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               )
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               // foodCounter == 1 && showDeleteButton
//                               Expanded(child: Container(
//                                 margin: EdgeInsets.only(left: 10, right: 17, top: 30),
//                                 child: foodCounter == 1 && widget.foodItem.controlCart ?
//                                 Material(
//                                   color: Colors.transparent,
//                                   child: Card(
//                                     color: AppColors.kRed,
//                                     child: InkWell(
//                                       onTap: () {
//                                         widget.foodItem.controlCart = false;
//                                         widget.foodItem.quantity = 1;
//                                         HapticFeedback.lightImpact();
//                                         for(var i = 0; i < widget.foodItem.quantity; i++) {
//                                           cartViewModel.clearCartList(widget.foodItem);
//                                         }
//                                         Navigator.pop(context);
//                                         widget.onNext(false);
//                                       },
//                                       splashColor: AppColors.kRed4,
//                                       child: Container(
//                                         height: 48,
//                                         alignment: Alignment.center,
//                                         child: Text("Delete",
//                                           textScaleFactor: 1,
//                                           style: TextStyle(
//                                               fontFamily: AppStrings.dmBold,
//                                               fontSize: 15.2,
//                                               letterSpacing: -0.1,
//                                               color: Color(0xffffffff)
//                                           ),
//                                         )
//                                       ),
//                                     ),
//                                   ),
//                                 ) : Material(
//                                   color: Colors.transparent,
//                                   child: Card(
//                                     color: Color(0xff222222),
//                                     elevation: 2,
//                                     child: InkWell(
//                                       onTap: () {
//                                         widget.foodItem.controlCart = false;
//                                         widget.foodItem.quantity = 1;
//                                         HapticFeedback.lightImpact();
//                                         for(var i = 0; i < widget.foodItem.quantity; i++) {
//                                           cartViewModel.clearCartList(widget.foodItem);
//                                         }
//                                         Future.delayed(Duration(milliseconds: 500));
//                                         for(var i = 0; i < foodCounter; i++) {
//                                           cartViewModel.addToList(widget.foodItem);
//                                         }
//                                         Navigator.pop(context);
//                                         widget.onNext(true);
//                                       },
//                                       splashColor: Color(0xff141414),
//                                       child: Container(
//                                         height: 48,
//                                         child: Row(
//                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Expanded(
//                                               child: Container(
//                                                 color: Colors.transparent,
//                                                 padding: const EdgeInsets.only(left: 15),
//                                                 child: Text("Add to Cart",
//                                                   textScaleFactor: 1,
//                                                   style: TextStyle(
//                                                       fontFamily: AppStrings.dmBold,
//                                                       fontSize: 15.2,
//                                                       letterSpacing: -0.1,
//                                                       color: Color(0xffffffff)
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                             Container(
//                                               margin: EdgeInsets.only(right: 15),
//                                               color: Colors.transparent,
//                                               width: 70,
//                                               child: RichText(
//                                                 overflow: TextOverflow.ellipsis,
//                                                 textScaleFactor: 1,
//                                                 textAlign: TextAlign.right,
//                                                 text: TextSpan(
//                                                     children: <TextSpan>[
//                                                       TextSpan(
//                                                         // ${AppStrings.nairaSymbol}
//                                                         text: '${AppStrings.nairaSymbol}',
//                                                         style: TextStyle(
//                                                             fontSize: 12,
//                                                             fontFamily: AppStrings.dmMedium,
//                                                             color: Colors.white),),
//                                                       TextSpan(
//                                                           text: '${thousandFormatter.format(num.tryParse(returnTotalAmount(context, widget.foodItem)))}', style: TextStyle(
//                                                           fontFamily: AppStrings.dmRegular,
//                                                           fontSize: 13,
//                                                           height: 1.4,
//                                                           color: Color(0xffEDE9E0))),
//
//                                                     ]),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ))
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   String returnTotalAmount(BuildContext context, FoodItemModel orderItems) {
//     ABSCartViewModel cartViewModel = Provider.of(context);
//     double totalAmount = 0.0;
//     totalAmount = totalAmount + double.tryParse(orderItems.productPrice) * foodCounter;
//     setState(() {});
//     // totalAmount = totalAmount + double.tryParse(orderItems.productPrice) * orderItems.quantity;
//     print("total amount is ${cartViewModel.totalAmount}");
//     return totalAmount.toStringAsFixed(2);
//   }
// }
