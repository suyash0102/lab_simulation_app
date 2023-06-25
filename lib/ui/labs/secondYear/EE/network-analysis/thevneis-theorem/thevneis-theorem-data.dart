import 'package:flutter/material.dart';
import 'package:lab_simulation_app/ui/labs/secondYear/EE/machine/ocTest/oc_test.dart';

const List<String> thevneisOptionOne = [
  '',
  'I, II, III',
  'l.v. side',
  'B, D',
  'B, D',
  'Efficiency',
];
const List<String> thevneisOptionTwo = [
  '',
  'I, II',
  'h.v. side',
  'A, B, C',
  'A, B, C',
  'Equivalent impedance of one side of the winding',
];
List<String> thevneisOptionThree = [
  '',
  'II, III',
  'primary',
  'B, C, D',
  'B, C, D',
  'Voltage regulation for exact circuit',
];
List<String> thevneisOptionFour = [
  '',
  'I, III',
  'secondary',
  'A, C, D',
  'A, C, D',
  'All of the mentioned',
];

int thevneisNoOfQuestions = 5;

List<int> thevneisCorrectAnswers = [
  1,
  1,
  4,
  1,
  1,
];
List<String> thevneisQuestionsList = [
  '',
  'The open circuit test results in finding which of the following parameters? \n I. core losses \n II. shunt branch parameters \n III. turns ratio of transformer',
  'To conduct the open circuit test, test is conducted on the _____________',
  'Which of the following conditions have to ensured for a open-circuit test?\n A. Performed on L.V side \n B. Leakage impedance can be obtained \n C. It is performed at rated voltage \n D. It gives magnetizing impedance',
  'Which of the following conditions have to ensured for a open-circuit test? \n A. Performed on L.V side \n B. Leakage impedance can be obtained \n C. It is performed at 10-12% of rated voltage \n D. It gives magnetizing impedance',
  'Which of the below estimations require results of both open circuit test and short circuit test?',
];

String thevneisTitle = "Thevneis Theorem";

String thevneisAim = 'thevenin theorem.';

Widget thevneisExperimentScreen = const OCTestScreen();

List<String> thevneisProcedure = [
  'Calculation of the open circuit voltage or thevenin voltage.\n',
  'Open the circuit from R3\n',
  'Then calculate the current in the circuit(I)\n',
  'Then Find voltage (open circuit)\n',
  'Short the supply voltage side\n',
  'Calculate the Thevenin resistance\n',
  'Calculate the Thevenin resistance\n',
  'Calculate the load current(I_load)'
];

String thevneisTheory = "As per Thevenin’s theorem, any two terminal network containing a number of emf sources and resistance can be replaced by an equivalent simple series circuit of one voltage source and one resistance. The voltage and resistance are called Thevenin’s equivalent. These are denoted by VTh (Thevenin’s Voltage) and RTh (Thevenin’ resistance).";
String thevneisCalculations =
    '\n \u2022 I=v_supply/r1+r2 \n \u2022 V0c=r2*I \n \u2022 Rth=(r1*r2)/(r1+r2) \n \u2022 CI_load=Voc/Rth+r3';

List<String> vivaQuestions = [
  'What is the significance of O.C and D.C test?',
  'Why H.V winding is kept open during O.C test and 1 v winding is shorted during S.C test in case of large transformers?',
  'In O.C test, a voltmeter is connected across secondary winding and still it is called as O.C test. Why?',
  'What will happen if dc supply instead of ac supply is applied to a transformer?',
  'Which is the alternate method for finding efficiency and regulation of a transformer other than O.C and S.C tests/ What are their advantages over each other?',
  'What is the importance of equivalent circuit?',
  'Why regulation of transformer is negative for leading p.f load?'
];