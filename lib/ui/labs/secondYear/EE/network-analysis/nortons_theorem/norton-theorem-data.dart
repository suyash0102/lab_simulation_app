import 'package:flutter/material.dart';
import 'package:lab_simulation_app/ui/labs/secondYear/EE/machine/ocTest/oc_test.dart';

const List<String> nortonOptionOne = [
  '',
  'I, II, III',
  'l.v. side',
  'B, D',
  'B, D',
  'Efficiency',
];
const List<String> nortonOptionTwo = [
  '',
  'I, II',
  'h.v. side',
  'A, B, C',
  'A, B, C',
  'Equivalent impedance of one side of the winding',
];
List<String> nortonOptionThree = [
  '',
  'II, III',
  'primary',
  'B, C, D',
  'B, C, D',
  'Voltage regulation for exact circuit',
];
List<String> nortonOptionFour = [
  '',
  'I, III',
  'secondary',
  'A, C, D',
  'A, C, D',
  'All of the mentioned',
];

int nortonNoOfQuestions = 5;

List<int> nortonCorrectAnswers = [
  1,
  1,
  4,
  1,
  1,
];
List<String> nortonQuestionsList = [
  '',
  'The open circuit test results in finding which of the following parameters? \n I. core losses \n II. shunt branch parameters \n III. turns ratio of transformer',
  'To conduct the open circuit test, test is conducted on the _____________',
  'Which of the following conditions have to ensured for a open-circuit test?\n A. Performed on L.V side \n B. Leakage impedance can be obtained \n C. It is performed at rated voltage \n D. It gives magnetizing impedance',
  'Which of the following conditions have to ensured for a open-circuit test? \n A. Performed on L.V side \n B. Leakage impedance can be obtained \n C. It is performed at 10-12% of rated voltage \n D. It gives magnetizing impedance',
  'Which of the below estimations require results of both open circuit test and short circuit test?',
];

String nortonTitle = "Norton's Theorem";

String nortonAim = 'Norton\'s theorem.';

Widget nortonExperimentScreen = const OCTestScreen();

List<String> nortonProcedure = [
  'Consider the circuit diagram by opening the terminals with respect to which, the Norton’s equivalent circuit is to be found.\n',
  'Find the Norton’s current IN by shorting the two opened terminals of the above circuit\n',
  'Find the Norton’s resistance RN across the open terminals of the circuit considered in Step1 by eliminating the independent sources present in it. Norton’s resistance RN will be same as that of Thevenin’s resistance RTh.\n',
  'Then Find voltage (open circuit)\n',
  'Find load current.\n',
];

String nortonTheory = "Norton’s theorem is similar to Thevenin’s theorem. It states that any two terminal linear network or circuit can be represented with an equivalent network or circuit, which consists of a current source in parallel with a resistor. It is known as Norton’s equivalent circuit. A linear circuit may contain independent sources, dependent sources and resistors.";
String nortonCalculations =
    '\n \u2022 IN = V_Supply /  r1 \n \u2022 RN = r1*r2 / r1+r2  \n \u2022 IL =(RN *IN /RN +r3) \n';

List<String> vivaQuestions = [
  'What is the significance of O.C and D.C test?',
  'Why H.V winding is kept open during O.C test and 1 v winding is shorted during S.C test in case of large transformers?',
  'In O.C test, a voltmeter is connected across secondary winding and still it is called as O.C test. Why?',
  'What will happen if dc supply instead of ac supply is applied to a transformer?',
  'Which is the alternate method for finding efficiency and regulation of a transformer other than O.C and S.C tests/ What are their advantages over each other?',
  'What is the importance of equivalent circuit?',
  'Why regulation of transformer is negative for leading p.f load?'
];