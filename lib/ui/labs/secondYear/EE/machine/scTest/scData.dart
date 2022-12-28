import 'package:flutter/material.dart' show Widget;
import 'package:lab_simulation_app/ui/labs/secondYear/EE/machine/scTest/sc_test.dart';

const List<String> scOptionOne = [
  '',
  'l.v. side',
  '200V,10A',
  'I, II',
  'A, B',
  'arc welding',
];
const List<String> scOptionTwo = [
  '',
  'h.v. side',
  '20V, 10A',
  'II, III',
  'A, B, C',
  'power distribution',
];
List<String> scOptionThree = [
  '',
  'primary',
  '300V,100A',
  'I, II, IV',
  'B, C',
  'power generating terminals',
];
List<String> scOptionFour = [
  '',
  'secondary',
  '200V,50A',
  'II, III',
  'A, C',
  'none of the mentioned',
];

int scNoOfQuestions = 5;

List<int> scCorrectAnswers = [
  2,
  1,
  4,
  1,
  1,
];
List<String> scQuestionsList = [
  '',
  'To conduct the short circuit test, test is conducted on the ___________',
  'A single phase transformer of 2000/200 V having rated l.v. current of 100 A has to undergo a short circuit test on l.v. side. Which of the range of the below instrument should be used?',
  'Which of the following information is not obtained from short-circuit test? \n I. Ohmic losses at rated current \n II. Equivalent resistance and leakage reactance \n III. Core losses \n IV. Voltage regulation',
  'Which of the following conditions have to ensured for a short-circuit test? \n A. L.v. is short circuited \n B. It helps in calculation of voltage regulation \n C. It is performed at rated voltage',
  'Transformers with high leakage impedance is used in ___________',
];

String scTitle = "Short Circuit Experiment";

String scAim = 'To perform Short Circuit test on Single Phase Transformer.';

Widget scExperimentScreen = const SCTestScreen();

List<String> scProcedure = [
  'Ensure that slider is set to zero output voltage position before starting the experiment.\n',
  'Switch ON the supply. Now apply the rated current of 2.17A to the Primary winding by using slider.\n',
  'The readings of the Voltmeter, ammeter and wattmeter are shown. Click on Add to Observation Table Button to add readings to Observation Table.\n',
  'Then go to Observation Table Tab, the readings are shown in Tabular form. Now calculate manually the Ro1 and Zo1 & different values shown below using the formula given. Type your values and then Click Submit.\n',
  'Correct values are shown after you click on submit',
  'Now you can take the quiz on the topic.'
];

String scTheory = 'A voltmeter, wattmeter, and an ammeter are connected in LV side of the transformer as shown. The voltage at rated frequency is applied to that LV side with the help of a slider of variable ratio auto transformer. The HV side of the transformer is kept open. Now with help of slider applied voltage is slowly increase until the voltmeter gives reading equal to the rated voltage of the LV side. After reaching at rated LV side voltage, three instruments reading (Voltmeter, Ammeter and Wattmeter readings) are recorded. Ammeter reading gives the no load current I0. As no load current I0 is quite small compared to the rated current of the transformer, the voltage drops due to this electric current can be taken as negligible. \n Since, voltmeter reading V; can be considered equal to secondary induced voltage of the transformer. The input power during test is indicated by wattmeter reading. As the transformer is open circuited, there is no output hence the input Power here consists of core losses in transformer and copper loss in transformer during no load condition. But as said earlier, the no load current in the transformer is quite small compared to full load current so copper loss due to the small no load current can be neglected. Hence the wattmeter reading can be taken as equal to core losses in transformer. \n . A voltmeter, wattmeter, and an ammeter are connected In HV slide of the transformer as shown. The voltage at rated frequency Is applied to that HV side with the help of a slider of variable ratio autotransformer. \n The LV side of the transformer Is short-circuited. Now with help of slider applied voltage Is slowly increase until the ammeter gives a reading equal to the rated current of the HV side. After reaching at rated current of HV side, all three Instruments reading (Voltmeter, Ammeter and Wattmeter readings) are recorded. The ammeter reading gives the primary equivalent of full load current IL. As the voltage, applied for full load current in short circuit test on transformer, Is quite small compared to rated primary voltage of the transformer, the core losses In transformer can be taken as negligible here.';
String scCalculations =
'\n \u2022 Equivalent resistance referred to HV side, R01 = Wsc/ Isc2 \n \u2022 Equivalent impedance referred to HV side, Z01 = Vsc / Isc \n \u2022 Equivalent leakage reactance referred to HV side, X01 = √ (Z201 – R201) \n \u2022 And also short circuit power factor, Cos Φsc = Wsc/VscIsc';