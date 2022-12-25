import 'package:flutter/material.dart';
import 'package:lab_simulation_app/ui/labs/secondYear/EE/machine/ocTest/oc_test.dart';

const List<String> ocOptionOne = [
  '',
  'I, II, III',
  'l.v. side',
  'B, D',
  'B, D',
  'Efficiency',
];
const List<String> ocOptionTwo = [
  '',
  'I, II',
  'h.v. side',
  'A, B, C',
  'A, B, C',
  'Equivalent impedance of one side of the winding',
];
List<String> ocOptionThree = [
  '',
  'II, III',
  'primary',
  'B, C, D',
  'B, C, D',
  'Voltage regulation for exact circuit',
];
List<String> ocOptionFour = [
  '',
  'I, III',
  'secondary',
  'A, C, D',
  'A, C, D',
  'All of the mentioned',
];

int ocNoOfQuestions = 5;

List<int> ocCorrectAnswers = [
  1,
  1,
  4,
  1,
  1,
];
List<String> ocQuestionsList = [
  '',
  'The open circuit test results in finding which of the following parameters? \n I. core losses \n II. shunt branch parameters \n III. turns ratio of transformer',
  'To conduct the open circuit test, test is conducted on the _____________',
  'Which of the following conditions have to ensured for a open-circuit test?\n A. Performed on L.V side \n B. Leakage impedance can be obtained \n C. It is performed at rated voltage \n D. It gives magnetizing impedance',
  'Which of the following conditions have to ensured for a open-circuit test? \n A. Performed on L.V side \n B. Leakage impedance can be obtained \n C. It is performed at 10-12% of rated voltage \n D. It gives magnetizing impedance',
  'Which of the below estimations require results of both open circuit test and short circuit test?',
];

String ocTitle = "Open Circuit Experiment";

String ocAim = 'To perform Open Circuit test on Single Phase Transformer.';

Widget ocExperimentScreen = const OCTestScreen();

List<String> ocProcedure = [
  'Ensure that slider is set to zero output voltage position before starting the experiment.\n',
  'Switch ON the supply. Now apply the rated voltage of 115V to the Primary winding by using slider.\n',
  'The readings of the Voltmeter, ammeter and wattmeter are shown. Click on Add to Observation Table Button to add readings to Observation Table.\n',
  'Then go to Observation Table Tab, the readings are shown in Tabular form. Now calculate manually the Ro and Xo & different values shown below using the formula given. Type your values and then Click Submit.\n',
  'Correct values are shown after you click on submit',
  'Now you can take the quiz on the topic.'
];

String ocTheory =
    "The connection diagram for open circuit test on transformer is shown above. A voltmeter, wattmeter, and an ammeter are connected in LV side of the transformer as shown. The voltage at rated frequency is applied to that LV side with the help of a variac of variable ratio auto transformer. The HV side of the transformer is kept open. Now with help of variac applied voltage is slowly increase until the voltmeter gives reading equal to the rated voltage of the LV side. After reaching at rated LV side voltage, all three instruments reading (Voltmeter, Ammeter and Wattmeter readings) are recorded. \nThe ammeter reading gives the no load current I0. As no load current I0 is quite small compared to the rated current of the transformer, the voltage drops due to this electric current can be taken as negligible. Since, voltmeter reading V; can be considered equal to secondary induced voltage of the transformer. The input power during test is indicated by wattmeter reading. As the transformer is open circuited, there is no output hence the input Power here consists of core losses in transformer and copper loss in transformer during no load condition. \n\nBut as said earlier, the no load current in the transformer is quite small compared to full load current so copper loss due to the small no load current can be neglected. \nHence the wattmeter reading can be taken as equal to core losses in transformer. The connection diagram for short circuit test on transformer Is shown in the figure. A voltmeter, wattmeter, and an ammeter are connected In HV slide of the transformer as shown. The voltage at rated frequency Is applied to that HV side with the help of a variac of variable ratio autotransformer. \nThe LV side of the transformer Is short-circuited. \n Now with help of variac applied voltage Is slowly increase until the ammeter gives a reading equal to the rated current of the HV side. After reaching at rated current of HV side, all three Instruments reading (Voltmeter, Ammeter and Wattmeter readings) are recorded. The ammeter reading gives the primary equivalent of full load current IL. As the voltage, applied for full load current in short circuit test on transformer, Is quite small compared to rated primary voltage of the transformer, the core losses In transformer can be taken as negligible here.";
String ocCalculations =
    '\n \u2022 No load power factor, Cos Φo = Wo/V1 x Io \n \u2022 Magnetizing component of Io, Im = Io sin Φo Amps. \n \u2022 Core loss component of Io = Ic = Io cos Φo Amps. \n \u2022 Core loss resistance Ro = V1 / Ic ohm. \n \u2022 Magnetizing reactance Xo= V1 / Im ohms.';
