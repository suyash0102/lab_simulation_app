import 'package:flutter/material.dart';
import 'package:lab_simulation_app/constants.dart';
import 'package:lab_simulation_app/ui/faculty_module/screens/viva_voice_marking_screen.dart';
import 'package:lab_simulation_app/ui/labs/secondYear/EE/machine/fieldControl/field_control.dart';
import 'package:lab_simulation_app/ui/labs/secondYear/EE/machine/ocTest/oc_test.dart';
import 'package:lab_simulation_app/ui/labs/secondYear/EE/machine/rotate.dart';
import 'package:lab_simulation_app/ui/labs/secondYear/EE/machine/scTest/sc_test.dart';

class FMLabsScreen extends StatefulWidget {
  const FMLabsScreen({Key? key}) : super(key: key);

  @override
  _FMLabsScreenState createState() => _FMLabsScreenState();
}

class _FMLabsScreenState extends State<FMLabsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Experiments',
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
        // bottomNavigationBar: const FMBottomNavBar()
    );
  }
}

class Choice {
  const Choice(
      {required this.simulationScreen,
        required this.expName,
        required this.expNo});

  final String expName;
  final int expNo;
  final simulationScreen;
}

const List<Choice> choices = <Choice>[
  Choice(
      expName: 'To perform Open Circuit test on Single Phase Transformer.',
      expNo: 1,
      simulationScreen: OCTestScreen()),
  Choice(
      expName: 'To perform Short Circuit test on Single Phase Transformer.',
      expNo: 2,
      simulationScreen: SCTestScreen()),
  Choice(
      expName:
      'To Control the Speed of DC Shunt motor by using Field Control Method.',
      expNo: 3,
      simulationScreen: FieldControlScreen()),
  Choice(
      expName:
      'To Control the Speed of DC Shunt motor by using Armature Control Method.',
      expNo: 4,
      simulationScreen: LogoRotate()),
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
              return choice.simulationScreen;
            },
          ),
        );
      },
      child: Card(
        elevation: 8,
        child: Padding(
          padding: EdgeInsets.all(size.width * 0.025),
          child: SizedBox(
            width: size.width * 0.38,
            height: size.height * 0.09,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Experiment: ${choice.expNo}',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      fontSize: size.width * 0.045,
                      color: kfmPrimaryColor),
                ),
                Text(
                  'Aim: ${choice.expName}',
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
