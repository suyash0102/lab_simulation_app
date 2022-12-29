// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:lab_simulation_app/constants.dart';
// import 'package:lab_simulation_app/ui/faculty_module/screens/fm_lab_sub_screen.dart';
//
// class FMHomeScreen extends StatefulWidget {
//   const FMHomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<FMHomeScreen> createState() => _FMHomeScreenState();
// }
//
// class _FMHomeScreenState extends State<FMHomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     Orientation orientation = MediaQuery.of(context).orientation;
//     return  Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         SizedBox(
//           height: orientation == Orientation.portrait
//               ? size.height * 0.02
//               : size.height * 0.01,
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Card(
//               elevation: 8,
//               child: SizedBox(
//                 width: orientation == Orientation.portrait
//                     ? size.width * 0.45
//                     : size.width * 0.14,
//                 height: orientation == Orientation.portrait
//                     ? size.height * 0.227
//                     : size.height * 0.29,
//                 child: Column(
//                   children: [
//                     SizedBox(
//                         width: orientation == Orientation.portrait
//                             ? size.width * 0.45
//                             : size.width * 0.14,
//                         child: Image.asset('assets/images/electrical.png')),
//                     Padding(
//                       padding: EdgeInsets.only(
//                           left: orientation == Orientation.portrait
//                               ? size.width * 0.02
//                               : size.width * 0.005,
//                           right: orientation == Orientation.portrait
//                               ? size.width * 0.02
//                               : size.width * 0.005),
//                       child: Text(
//                         'Electrical Engineering',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                             fontSize: orientation == Orientation.portrait
//                                 ? size.width * 0.031
//                                 : size.width * 0.01,
//                             fontFamily: 'Poppins',
//                             fontWeight: FontWeight.w700),
//                       ),
//                     ),
//                     Text(
//                       'Number of Labs: xx',
//                       style: TextStyle(
//                           fontSize: orientation == Orientation.portrait
//                               ? size.width * 0.03
//                               : size.width * 0.01,
//                           fontFamily: 'Poppins',
//                           fontWeight: FontWeight.w200),
//                     ),
//                     SizedBox(
//                       height: orientation == Orientation.portrait
//                           ? size.height * 0.02
//                           : size.height * 0.01,
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) {
//                               return const FMLabsSubScreen();
//                             },
//                           ),
//                         );
//                       },
//                       child: Container(
//                         decoration: BoxDecoration(
//                             color: kPrimaryColor,
//                             borderRadius: BorderRadius.all(Radius.circular(
//                                 orientation == Orientation.portrait
//                                     ? size.width * 0.01
//                                     : size.width * 0.01))),
//                         child: Padding(
//                           padding: EdgeInsets.all(
//                               orientation == Orientation.portrait
//                                   ? size.width * 0.01
//                                   : size.width * 0.005),
//                           child: Text(
//                             'Learn More',
//                             style: TextStyle(
//                                 fontSize: orientation == Orientation.portrait
//                                     ? size.width * 0.035
//                                     : size.width * 0.014,
//                                 fontFamily: 'Poppins',
//                                 color: Colors.white),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: orientation == Orientation.portrait
//                           ? size.height * 0.02
//                           : size.height * 0.01,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//         SizedBox(
//           height: orientation == Orientation.portrait
//               ? size.height * 0.01
//               : size.height * 0.00,
//         ),
//       ],
//     );
//   }
// }
