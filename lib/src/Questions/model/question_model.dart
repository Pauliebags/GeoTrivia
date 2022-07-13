import 'package:flutter/material.dart';

class QuestionModel {
  dynamic flag;
  String? question;
  Map<String, bool>? answers;
  QuestionModel({this.question,required this.answers,this.flag});
}
