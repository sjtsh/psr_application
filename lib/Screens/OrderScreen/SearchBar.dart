// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:psr_application/StateManagement/OrderScreenManagement.dart';
//
// class SearchBarState extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 50,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         border: Border(
//           bottom: BorderSide(
//             color: Colors.black.withOpacity(0.1),
//           ),
//         ),
//       ),
//       child: Center(
//         child: Container(
//           margin: EdgeInsets.symmetric(horizontal: 12),
//           height: 35,
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: Colors.black.withOpacity(0.1),
//             ),
//             color: Color(0xffF5F5F5),
//             borderRadius: BorderRadius.circular(5),
//           ),
//           child: Row(
//             children: [
//               SizedBox(
//                 width: 12,
//               ),
//               Expanded(
//                 child: Container(
//                   alignment: Alignment.centerLeft,
//                   width: double.infinity,
//                   child: Center(
//                     child: TextField(
//                         cursorColor: Colors.black,
//                         textAlignVertical: TextAlignVertical.center,
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 16,
//                         ),
//                         decoration: InputDecoration(
//                           isCollapsed: true,
//                           border: InputBorder.none,
//                           hintText: "Search Products",
//                           hintStyle: TextStyle(
//                             color: Colors.black.withOpacity(0.3),
//                             fontSize: 16,
//                           ),
//                         ),
//                         onChanged: (String _products) {
//                           if (_products != "") {
//                             context
//                                 .read<OrderScreenManagement>()
//                                 .searchProducts(_products);
//                           } else {
//                             context
//                                 .read<OrderScreenManagement>()
//                                 .dataToDisplay = null;
//                           }
//                         }),
//                   ),
//                 ),
//               ),
//               Container(
//                 width: 1,
//                 height: 30,
//                 decoration: BoxDecoration(
//                   border: Border(
//                     right: BorderSide(
//                       color: Colors.black.withOpacity(0.1),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 width: 10,
//               ),
//               SizedBox(
//                 width: 80,
//                 child: DropdownButton<String>(
//                   icon: Icon(Icons.keyboard_arrow_down_rounded),
//                   isExpanded: true,
//                   value: context
//                       .watch<OrderScreenManagement>()
//                       .dropdownValueFilter,
//                   underline: Container(),
//                   iconSize: 12,
//                   elevation: 0,
//                   style: const TextStyle(
//                     color: Colors.black,
//                     fontSize: 14,
//                   ),
//                   onChanged: (newValue) {
//                     context.read<OrderScreenManagement>().dropdownValueFilter =
//                         newValue ?? "All";
//                   },
//                   items: <String>['All', 'Promoted', 'New', 'Trending']
//                       .map<DropdownMenuItem<String>>((String value) {
//                     return DropdownMenuItem<String>(
//                       value: value,
//                       child: Text(
//                         value,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     );
//                   }).toList(),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
