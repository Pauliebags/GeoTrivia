import 'package:flag/flag_enum.dart';
import 'package:flag/flag_widget.dart';
import 'model/question_model.dart';
List<QuestionModel> naQuestions=[
        QuestionModel(
              flag: Flag.fromCode(
                  FlagsCode.KI,height: 100,width: double.infinity),
            question:
      "What is the tallest mountain in the North America?",
answers: {
      "Mount Logan": false,
      "Mount Foraker": false,
      "Denali": true,
      "Mount Vancouver": false,
      }),
      QuestionModel(
          question:
      "What is the longest river in the North America?",
answers: {
      "Yukon River": false,
      "Rio Grande": false,
      "Missouri River": true,
      "Colorado River": false,
      }),
      QuestionModel(
          question:
      "Which has the highest population?",
answers: {
      "California": true,
      "Canada": false,
      "Texas": false,
      "Mexico City": false,
      }),
      QuestionModel(
          question:
      "What is the largest city by square miles in North America?",
answers: {
      "New York City": false,
      "Mexico City": true,
      "Los Angeles": false,
      "California": false,
      }),
      QuestionModel(
          question:
      "What is the largest lake in North America?",
answers: {
      "Lake Superior": true,
      "Lake Michigan": false,
      "Lake Winnipeg": false,
      "Great Bear Lake": false,
      }),
      QuestionModel(
          question:
      "How many time zones are there in the USA?",
answers: {
      "4": false,
      "5": false,
      "6": true,
      "7": false,
      }),
      QuestionModel(
          question:
      "The Panama Canal is considered one of the engineering wonders of the world. How many workers are estimated to have died during it's construction?",
answers: {
      "5000+": false,
      "15000+": false,
      "25000+": true,
      "50000+": false,
      }),
      QuestionModel(
          question:
      "There are over 7000 Caribbean islands. Approx how many are inhabited by humans?",
answers: {
      "Approx 50": false,
      "Approx 150": true,
      "Approx 500": false,
      "Approx 2000": false,
      }),
      QuestionModel(
        question:
      "Which US State has the largest coastline?",
answers: {
      "Hawaii": false,
      "Florida": false,
      "California": false,
      "Alaska": true,
      }),
      QuestionModel(
        question:
      "What is the official language of the USA?",
    answers: {
      "French": false,
      "English": false,
      "Spanish": false,
      "No official language": true,
    },
  ),
];