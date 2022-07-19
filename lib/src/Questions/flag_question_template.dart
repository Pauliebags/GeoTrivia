import 'package:flag/flag.dart';
import 'package:flag/flag_enum.dart';
import 'package:flag/flag_widget.dart';

import 'model/question_model.dart';

List<QuestionModel> flQuestions = [
  QuestionModel(
      flag: Flag.fromCode(FlagsCode.KI, height: 100, width: double.infinity),
      question: "Which country's flag is this?",
      answers: {
        "Singapore": false,
        "Norway": false,
        "Kiribati": true,
        "Uruguay": false,
      }),
  QuestionModel(
      flag: Flag.fromCode(FlagsCode.GB, height: 100, width: double.infinity),
      question: "Which country's flag is this?",
      answers: {
        "Australia": false,
        "Canada": false,
        "United Kingdom": true,
        "New Zealand": false,
      }),
  QuestionModel(
      flag: Flag.fromCode(FlagsCode.IN, height: 100, width: double.infinity),
      question: "Which country's flag is this?",
      answers: {
        "India": true,
        "Republic of Ireland": false,
        "Cote D'Ivoire": false,
        "Turkey": false,
      }),
  QuestionModel(
      flag: Flag.fromCode(FlagsCode.DE, height: 100, width: double.infinity),
      question: "Which country's flag is this?",
      answers: {
        "Belgium": false,
        "Germany": true,
        "Denmark": false,
        "Norway": false,
      }),
  QuestionModel(
      flag: Flag.fromCode(FlagsCode.GE, height: 100, width: double.infinity),
      question: "Which country's flag is this?",
      answers: {
        "England": false,
        "Denmark": false,
        "Sweden": false,
        "Georgia": true,
      }),
  QuestionModel(
      flag: Flag.fromCode(FlagsCode.FI, height: 100, width: double.infinity),
      question: "Which country's flag is this?",
      answers: {
        "Greece": false,
        "Finland": true,
        "Norway": false,
        "Scotland": false,
      }),
  QuestionModel(
      flag: Flag.fromCode(FlagsCode.MX, height: 100, width: double.infinity),
      question: "Which country's flag is this?",
      answers: {
        "Mexico": true,
        "Peru": false,
        "Colombia": false,
        "Brazil": false,
      }),
  QuestionModel(
      flag: Flag.fromCode(FlagsCode.KR, height: 100, width: double.infinity),
      question: "Which country's flag is this?",
      answers: {
        "South Korea": true,
        "North Korea": false,
        "Japan": false,
        "Vietnam": false,
      }),
  QuestionModel(
      flag: Flag.fromCode(FlagsCode.ES, height: 100, width: double.infinity),
      question: "Which country's flag is this?",
      answers: {
        "Albania": false,
        "Portugal": false,
        "Spain": true,
        "Algeria": false,
      }),
  QuestionModel(
      flag: Flag.fromCode(FlagsCode.CA, height: 100, width: double.infinity),
      question: "Which country's flag is this?",
      answers: {
        "Canada": true,
        "Australia": false,
        "New Zealand": false,
        "Great Britain": false,
      }),
];
