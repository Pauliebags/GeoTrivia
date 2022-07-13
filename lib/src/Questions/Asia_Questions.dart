import 'package:flag/flag_enum.dart';
import 'package:flag/flag_widget.dart';
import 'model/question_model.dart';

List<QuestionModel> asQuestions=[
 QuestionModel(
question:
 "Which is Asia's largest country?",
answers: {
 "India": false,
 "China": false,
 "Saudi Arabia": false,
 "Russia": true,
 },
 ),
 QuestionModel(
     question:
 "Which is the most densely populated country in Asia?",
answers: {
"India": false,
"Singapore": true,
"Japan": false,
"Vietnam": false,
}),

QuestionModel(
question: "How many landlocked countries are there in Asia?",
answers: {
"7": false,
 "12": true,
 "18": false,
 }),


 QuestionModel(
question:
 "What is the name of the largest desert in Asia?",
answers: {
 "Arabian Desert": false,
 "Sahara Desert": false,
 "Karakum Desert": false,
 "Gobi Desert": true,
 }),

 QuestionModel(
question:
 "Which is the highest building in Asia (and the world)?",
answers: {
 "Burj Khalifa": true,
 "Shanghai Tower": false,
    "Tokyo Tower": false,
 "Jin Mao Tower": false,
 }),

 QuestionModel(
question:
 "What is the name of the highest mountain in Asia?",
answers: {
 "Mount Fuji": false,
 "Mount Everest": true,
 "Kilamanjaro": false,
 "Mount Etna": false,
 }),

 QuestionModel(
question:
 "How many islands belong to the Maldives?",
answers: {
 "9": false,
 "19": false,
 "119": false,
 "1190": true,
 }),

 QuestionModel(
question:
 "What is the name of the longest river in Asia?",
answers: {
 "Godavari River": false,
 "Ganges": false,
 "Mekong River": false,
 "Yangtse River": true,
 }),

 QuestionModel(
question:
 "What is the currency used in China?",
answers: {
 "Yuan": true,
 "Dinar": false,
 "Ruble": false,
 "Won": false,
 }),

QuestionModel(
question:
 "How many recognised languages are spoken in India?",
answers: {
 "Over 10": false,
 "Over 20": true,
 "Over 50": false,
 "Over 100": false,
 }),
];
