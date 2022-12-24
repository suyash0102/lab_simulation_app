import 'package:flutter/material.dart';
import 'package:lab_simulation_app/ui/labs/secondYear/EE/machine/ocTest/oc_test.dart';

const List<String> ocOptionOne = [
  '',
  'Drone', // =>Correct Answer For Question NO:1
  'Constance',
  'Input',
  '1990',
  'Data processing',// =>Correct Answer For Question NO:5
  'Art',
  'Reasoning',// =>Correct Answer For Question NO:7
  'Wiring',
  'Compilation',
];
const List<String> ocOptionTwo = [
  '',
  '3D Printer',
  'Ability',
  'Intelligent agent',// =>Correct Answer For Question NO:3
  '1956',// =>Correct Answer For Question NO:4
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
  'Natural intelligence',// =>Correct Answer For Question NO:2
  'Data',
  '1912',
  'AI Effect',
  'Input',
  'Mastering',
  'Mathematics',// =>Correct Answer For Question NO:8
  'Knowledge engineering',// =>Correct Answer For Question NO:9
];
List<String> ocOptionFour = [
  '',
  'Amazon Alexa',
  'Cognition',
  'Processor',
  '1909',
  'Machination',
  'Neural networks',// =>Correct Answer For Question NO:6
  'Data',
  'French',
  'Mastering',
];

int ocNoOfQuestions=9;

List<String> ocQuestionsList = [
  '',
  'Which of the following\n technology used by zomato for\n food delivery ?', //question 1
  'The intelligence displayed by humans and other animals is termed?', //question 2
  'A program that can make decisions or perform a service based on its environment?',
  'In what year was Artificial intelligence founded as an academic discipline?',
  'An evolved definition of Artificial Intelligence led to a phenomenon known as the',
  'Which of these is a tool used in Artificial Intelligence?',
  'Which of the following is a fundamental goal of research in Artificial Intelligence?',
  'Which of these is a field that is closely related to AI?',
  'An essential field which is central to Artificial Intelligence research is?',
];

String ocTitle = "Open Circuit Experiment";

String ocAim='To perform Open Circuit test on Single Phase Transformer.';

Widget ocExperimentScreen=const OCTestScreen();
