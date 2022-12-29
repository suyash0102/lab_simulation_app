import 'package:flutter/material.dart';
import 'package:lab_simulation_app/constants.dart';
import 'package:lab_simulation_app/ui/coming_soon_screen.dart';
import 'package:lab_simulation_app/ui/faculty_module/screens/fm_lab_screen.dart';

class FMLabsSubScreen extends StatefulWidget {
  const FMLabsSubScreen({Key? key}) : super(key: key);

  @override
  _FMLabsSubScreenState createState() => _FMLabsSubScreenState();
}

class _FMLabsSubScreenState extends State<FMLabsSubScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lab Subjects',
          style: TextStyle(fontFamily: 'Poppins', color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: kfmPrimaryColor,
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: choices.length,
        itemBuilder: (BuildContext context, int index) {
          return SelectCard(choice: choices[index]);
        },
      ),
    );
  }
}

class Choice {
  const Choice(
      {required this.labsScreen,
        required this.sem,
        required this.year,
        required this.labSubName,
        required this.noExp});

  final String labSubName;
  final int noExp;
  final int sem;
  final int year;
  final labsScreen;
}

const List<Choice> choices = <Choice>[
  Choice(
      labSubName: 'Electrical Machines - 1',
      noExp: 4,
      sem: 3,
      year: 2,
      labsScreen: FMLabsScreen()),
  Choice(
      labSubName: 'Measurement & Instrumentation',
      noExp: 4,
      sem: 3,
      year: 2,
      labsScreen: ComingSoonScreen()),
  Choice(
      labSubName: 'Power Electronics',
      noExp: 4,
      sem: 5,
      year: 3,
      labsScreen: ComingSoonScreen()),
  Choice(
      labSubName: 'Power System',
      noExp: 4,
      sem: 5,
      year: 3,
      labsScreen: ComingSoonScreen()),
  Choice(
      labSubName: 'Microprocessor & Microcontroller',
      noExp: 4,
      sem: 5,
      year: 3,
      labsScreen: ComingSoonScreen()),
  Choice(
      labSubName: 'Power System Operation & Control',
      noExp: 4,
      sem: 7,
      year: 4,
      labsScreen: ComingSoonScreen()),
  Choice(
      labSubName: 'High Voltage Engineering',
      noExp: 4,
      sem: 7,
      year: 4,
      labsScreen: ComingSoonScreen()),
  Choice(
      labSubName: 'Electrical Drives',
      noExp: 4,
      sem: 7,
      year: 4,
      labsScreen: ComingSoonScreen()),
];

class SelectCard extends StatelessWidget {
  const SelectCard({super.key, required this.choice});

  final Choice choice;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return choice.labsScreen;
            },
          ),
        );
      },
      child: Card(
        elevation: 8,
        child: Padding(
          padding: EdgeInsets.all(size.width * 0.02),
          child: SizedBox(
            width: size.width * 0.38,
            height: size.height * 0.11,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  choice.labSubName,
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      fontSize: size.width * 0.045,
                      color: kfmPrimaryColor),
                ),
                Text(
                  'No. of Experiment: ${choice.noExp}',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: size.width * 0.034,
                  ),
                ),
                Text(
                  'Year: ${choice.year}',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: size.width * 0.034,
                  ),
                ),
                Text(
                  'Semester: ${choice.sem}',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: size.width * 0.034,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

