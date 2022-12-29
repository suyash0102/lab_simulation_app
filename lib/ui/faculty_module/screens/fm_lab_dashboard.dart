import 'package:flutter/material.dart';
import 'package:lab_simulation_app/constants.dart';
import 'package:lab_simulation_app/model/user.dart';
import 'package:lab_simulation_app/ui/home/dashboard/my_progress.dart';

import '../components/students_progress.dart';

class FMDashboardScreen extends StatefulWidget {
  const FMDashboardScreen({
    Key? key,
    required this.user,
  }) : super(key: key);
  final User user;

  @override
  _FMDashboardScreenState createState() => _FMDashboardScreenState();
}

class _FMDashboardScreenState extends State<FMDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding:
      EdgeInsets.only(left: size.width * 0.05, right: size.width * 0.05),
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.03,
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              "Progress",
              style: TextStyle(
                fontSize: size.width * 0.07,
                fontWeight: FontWeight.w600,
                fontFamily: "Poppins",
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              widget.user.branch,
              style: TextStyle(
                fontSize: size.width * 0.05,
                color: kfmPrimaryColor,
                fontWeight: FontWeight.w700,
                fontFamily: "Poppins",
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          const StudentsProgressArea(),
          SizedBox(
            height: size.height * 0.02,
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              'Experiments Completed:',
              style: TextStyle(
                fontSize: size.width * 0.06,
                fontWeight: FontWeight.w700,
                fontFamily: "Poppins",
              ),
            ),
          ),
          SizedBox(
            height: size.width * 0.05,
          ),
          Container(
            width: size.width * 0.95,
            height: size.height * 0.16,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black),
            ),
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.all(size.width * 0.03),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'To perform Open Circuit test on Single Phase Transformer.',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            fontSize: size.width * 0.04,
                            color: kfmPrimaryColor),
                      ),
                      SizedBox(
                        height: size.height * 0.005,
                      ),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadiusDirectional.circular(
                                    size.width * 0.02),
                                color: kfmPrimaryColor),
                            child: Icon(
                              Icons.done,
                              color: Colors.white,
                              size: size.width * 0.1,
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.04,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Date of Completion: 26-Dec-2022',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w300,
                                  fontSize: size.width * 0.03,
                                ),
                              ),
                              Text(
                                'Subject: Electrical Machine - 1',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w300,
                                  fontSize: size.width * 0.03,
                                ),
                              ),
                              Text(
                                'Status: Done',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w300,
                                  fontSize: size.width * 0.03,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.height * 0.1,
          ),
          Text(
            'UI is under development',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w300,
              fontSize: size.width * 0.03,
            ),
          ),
        ],
      ),
    );
  }
}
