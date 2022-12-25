import 'package:flutter/material.dart';
import 'package:lab_simulation_app/ui/labs/secondYear/EE/machine/ocTest/oc_test.dart';

const List<String> ocOptionOne = [
  '',
  'Drone', // =>Correct Answer For Question NO:1
  'Constance',
  'Input',
  '1990',
  'Data processing', // =>Correct Answer For Question NO:5
  'Art',
  'Reasoning', // =>Correct Answer For Question NO:7
  'Wiring',
  'Compilation',
];
const List<String> ocOptionTwo = [
  '',
  '3D Printer',
  'Ability',
  'Intelligent agent', // =>Correct Answer For Question NO:3
  '1956', // =>Correct Answer For Question NO:4
  'Globalisation',
  'AI Effect',
  'Design',
  'Coupling',
  'Drawing',
  'Art',
];
List<String> ocOptionThree = [
  '',
  'VR Box',
  'Natural intelligence', // =>Correct Answer For Question NO:2
  'Data',
  '1912',
  'AI Effect',
  'Input',
  'Mastering',
  'Mathematics', // =>Correct Answer For Question NO:8
  'Knowledge engineering', // =>Correct Answer For Question NO:9
];
List<String> ocOptionFour = [
  '',
  'Amazon Alexa',
  'Cognition',
  'Processor',
  '1909',
  'Machination',
  'Neural networks', // =>Correct Answer For Question NO:6
  'Data',
  'French',
  'Mastering',
];

int ocNoOfQuestions = 9;
List<int> ocCorrectAnswers = [1, 3, 2, 2, 1, 4, 1, 3, 3];
List<String> ocQuestionsList = [
  '',
  'Which of the following\n technology used by zomato for\n food delivery ?',
  //question 1
  'The intelligence displayed by humans and other animals is termed?',
  //question 2
  'A program that can make decisions or perform a service based on its environment?',
  'In what year was Artificial intelligence founded as an academic discipline?',
  'An evolved definition of Artificial Intelligence led to a phenomenon known as the',
  'Which of these is a tool used in Artificial Intelligence?',
  'Which of the following is a fundamental goal of research in Artificial Intelligence?',
  'Which of these is a field that is closely related to AI?',
  'An essential field which is central to Artificial Intelligence research is?',
];

String ocTitle = "Open Circuit Experiment";

String ocAim = 'To perform Open Circuit test on Single Phase Transformer.';

Widget ocExperimentScreen = const OCTestScreen();

String ocTheory =
    "The connection diagram for open circuit test on transformer is shown above . A voltmeter, wattmeter, and an ammeter are connected in LV side of the transformer as shown. The voltage at rated frequency is applied to that LV side with the help of a variac of variable ratio auto transformer. The HV side of the transformer is kept open. Now with help of variac applied voltage is slowly increase until the voltmeter gives reading equal to the rated voltage of the LV side. After reaching at rated LV side voltage, all three instruments reading (Voltmeter, Ammeter and Wattmeter readings) are recorded. \nThe ammeter reading gives the no load current I0. As no load current I0 is quite small compared to the rated current of the transformer, the voltage drops due to this electric current can be taken as negligible. Since, voltmeter reading V; can be considered equal to secondary induced voltage of the transformer. The input power during test is indicated by wattmeter reading. As the transformer is open circuited, there is no output hence the input Power here consists of core losses in transformer and copper loss in transformer during no load condition. \n\nBut as said earlier, the no load current in the transformer is quite small compared to full load current so copper loss due to the small no load current can be neglected. \nHence the wattmeter reading can be taken as equal to core losses in transformer. The connection diagram for short circuit test on transformer Is shown in the figure. A voltmeter, wattmeter, and an ammeter are connected In HV slide of the transformer as shown. The voltage at rated frequency Is applied to that HV side with the help of a variac of variable ratio autotransformer. \nThe LV side of the transformer Is short-circuited. \n Now with help of variac applied voltage Is slowly increase until the ammeter gives a reading equal to the rated current of the HV side. After reaching at rated current of HV side, all three Instruments reading (Voltmeter, Ammeter and Wattmeter readings) are recorded. The ammeter reading gives the primary equivalent of full load current IL. As the voltage, applied for full load current in short circuit test on transformer, Is quite small compared to rated primary voltage of the transformer, the core losses In transformer can be taken as negligible here.";
String ocCalculations =
    '\n \u2022 No load power factor =coso = Wo / Volo \n \u2022 Magnetizing component of Io = Ip = Io sino Amps. \n \u2022 Core loss component of Io Ic = Io cos_o amps. \n \u2022 Core loss resistance Ro = Vo/ Ic ohm. \n \u2022 Magnetizing reactance Xo = Vo/ Iy ohms. \n \u2022 Core loss in transformer at any load = Wo';
