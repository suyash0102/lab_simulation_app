import 'package:flutter/material.dart';
import 'package:lab_simulation_app/ui/labs/secondYear/EE/machine/scTest/sc_test.dart';

const List<String> fcOptionOne = [
  '',
  'Increasing the resistance in armature circuit',
  'Reducing the field current',
  'Lower-than-rated speeds',
  'True',
  '12.82 %',
];
const List<String> fcOptionTwo = [
  '',
  'Reducing the resistance in the field circuit',
  'Decreasing the armature current',
  'Greater than rated speeds',
  'False',
  '11.8 %',
];
List<String> fcOptionThree = [
  '',
  'Increasing the resistance in field circuit',
  ' Increasing the armature current',
  'Lower and greater than rated speeds',
  'Don\'t Now',
  '16.6 %',
];
List<String> fcOptionFour = [
  '',
  'Reducing the resistance in the armature circuit',
  'Increasing the excitation current',
  'Neither lower nor greater than rated speeds',
  'Can\'t Defined',
  '14.2 %',
];

int fcNoOfQuestions = 5;

List<int> fcCorrectAnswers = [
  3,
  1,
  2,
  2,
  2,
];
List<String> fcQuestionsList = [
  '',
  'The speed of a DC shunt motor can be increased by ______',
  'The speed of a DC shunt motor can be made more than full load speed by __________',
  'Which speeds can be obtained from field control of DC shunt motor?',
  'Speed regulation of DC shunt motor is calculated by ratio of difference of full load speed and no-load speed with full load speed.',
  'No load speed of the DC shunt motor is 1322 rpm while full load speed is 1182 rpm. What will be the speed regulation?',
];

String fcTitle = "Field Control Method";

String fcAim =
    'To Control the Speed of DC Shunt motor by using Field Control Method';

Widget fcExperimentScreen = const SCTestScreen();

List<String> fcProcedure = [
  'Coming Soon\n',
  'Coming Soon\n',
  'Coming Soon\n',
];

String fcTheory =
    'The speed of DC motor is inversely proposed to the flux per pole when the animated voltage is kept constant. By decreasing the flux the speed can be increased and vice versa. Hence the main flux of the field control method the flux of a DC  motor can be changed by changing the field current with help of a shunt field rheostat. Since the shunt field, current is respectively small shunt field rheostat has to carry only a small amount of current which means I2R losses are small so the rheostat is small in size. This method is very efficient.\nThe shunt motor has a definite no-load speed hence it does not run away when the load is suddenly thrown off provide the field circuit remains closed. The drop in speed from no-load to full load is mall hence this motor is usually referred to as a constant speed motor. The efficiency curve is usually of the same shape for all-electric motors and generators. The shape of the efficiency curve and the point of the maximum efficiency curve which is fairly flat. So that there are little changes in efficiency between load and 25% overload and to have the maximum efficiency as near to the full load as possible. From the curves, it is observed that the certain value of current  is required even when output is zero. The motor input under no-load conditions goes to meet the various losses occurring within the machine. As compared to other motors a shunt motor a shunt motor is incapable of starting heavy load. Actually it means that series and compound motor as capable of starting heavy load with les excess of current inputs over normal values then the shunt motor and the consequently the depreciation on the motor will be relatively less.\nThe emf equation of d.c machine is given by E = fPNZ/60A or E = KfN. the other parameter being constant for a particular machine or N = KE/f = K(V - IaRa)/f.\nSo, the speed can be controlled by three methods i.e by varying the field current keeping the armature voltage at constant. The speed is inversely proportional to the flux and is directly proportional to armature voltage. Load testing is process of putitng demand on a system or device and measuring its response. Load testing is performed to determine a system’s behavior under both normal and anticipated peak load conditions. It helps to identify the maximum operating  capacity of an application as well as any bottlenecks and determined which element is causing degradation. When the load placed on the system is raised beyond normal usage patterns, in order to test the system’s response at ususally high or peak loads, it is known as stress testing. The load is usually so great that error conditions are the expected result although no clear boundary exists when an activity ceases to be load test and becomes a stress test';

String fcCalculations = 'Coming Soon';

List<String> vivaQuestions = [
  'Why the motor is called a prime mover?',
  'On which factors the speed of the DC motor depends?',
  'Why the rheostat connected in the field circuit is kept at a minimum position at the time of starting?',
  'Where are these methods of speed control used?',
];
