import 'package:flag/flag_enum.dart';
import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';
import 'package:game_template/src/Questions/Africa_questions.dart';
import 'package:game_template/src/Questions/Asia_Questions.dart';
import 'package:game_template/src/Questions/Europe_Questions.dart';
import 'package:game_template/src/Questions/North_America_Questions.dart';
import 'package:game_template/src/Questions/Oceania_Questions.dart';
import 'package:game_template/src/Questions/South_America_Questions.dart';
import 'package:game_template/src/Questions/flag_question_template.dart';
import 'package:game_template/src/Questions/screens/result_screen.dart';

import '../data/questions_example.dart';
import '../ui/shared/color.dart';

int score = 0;
bool btnPressed = false;
bool answered = true;
String btnText = "Next Question";

class QuizzScreen extends StatefulWidget {
  String quizzCountry;
  QuizzScreen({required this.quizzCountry, Key? key}) : super(key: key);

  @override
  _QuizzScreenState createState() => _QuizzScreenState();
}

class _QuizzScreenState extends State<QuizzScreen> {
  int question_pos = 0;

  PageController? _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColor.pripmaryColor,
      body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: PageView.builder(
              controller: _controller!,
              onPageChanged: (page) {
                widget.quizzCountry == 'Europe'
                    ? page == euQuestions.length - 1
                    : widget.quizzCountry == 'North America'
                        ? page == naQuestions.length - 1
                        : widget.quizzCountry == 'Oceania'
                            ? page == ocQuestions.length - 1
                            : widget.quizzCountry == 'Asia'
                                ? page == asQuestions.length - 1
                                : widget.quizzCountry == 'Africa'
                                    ? page == afQuestions.length - 1
                                    : widget.quizzCountry == 'South America'
                                        ? page == saQuestions.length - 1
                                        : widget.quizzCountry == 'World Flags'
                                            ? page == flQuestions.length - 1
                                            : page == questions.length - 1
                                                ? setState(() {
                                                    btnText = "See Results";
                                                  })
                                                : setState(() {
                                                    answered = false;
                                                  });
              },
              physics: new NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Spacer(),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Question ${index + 1}/10",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28.0,
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    widget.quizzCountry == 'Europe'
                        ? euQuestions[index].flag == null
                            ? Container()
                            : euQuestions[index].flag
                        : widget.quizzCountry == 'North America'
                            ? naQuestions[index].flag == null
                                ? Container()
                                : naQuestions[index].flag
                            : widget.quizzCountry == 'Oceania'
                                ? ocQuestions[index].flag == null
                                    ? Container()
                                    : ocQuestions[index].flag
                                : widget.quizzCountry == 'Asia'
                                    ? asQuestions[index].flag == null
                                        ? Container()
                                        : asQuestions[index].flag
                                    : widget.quizzCountry == 'Africa'
                                        ? afQuestions[index].flag == null
                                            ? Container()
                                            : afQuestions[index].flag
                                        : widget.quizzCountry == 'South America'
                                            ? saQuestions[index].flag == null
                                                ? Container()
                                                : saQuestions[index].flag
                                            : widget.quizzCountry ==
                                                    'World Flags'
                                                ? flQuestions[index].flag ==
                                                        null
                                                    ? Container()
                                                    : flQuestions[index].flag
                                                : questions[index].flag == null
                                                    ? Container()
                                                    : questions[index].flag,
                    // SizedBox(
                    //   height: 10.0,
                    // ),
                    SizedBox(
                      width: double.infinity,
                      height: 200.0,
                      child: Text(
                        "${widget.quizzCountry == 'Europe' ? euQuestions[index].question : widget.quizzCountry == 'North America' ? naQuestions[index].question : widget.quizzCountry == 'Oceania' ? ocQuestions[index].question : widget.quizzCountry == 'Asia' ? asQuestions[index].question : widget.quizzCountry == 'Africa' ? afQuestions[index].question : widget.quizzCountry == 'South America' ? saQuestions[index].question : widget.quizzCountry == 'World Flags' ? flQuestions[index].question : questions[index].question}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.0,
                        ),
                      ),
                    ),
                    widget.quizzCountry == 'Europe'
                        ? BuildQ(quesIndex: euQuestions[index])
                        : widget.quizzCountry == 'North America'
                            ? BuildQ(quesIndex: naQuestions[index])
                            : widget.quizzCountry == 'Oceania'
                                ? BuildQ(quesIndex: ocQuestions[index])
                                : widget.quizzCountry == 'Asia'
                                    ? BuildQ(quesIndex: asQuestions[index])
                                    : widget.quizzCountry == 'Africa'
                                        ? BuildQ(quesIndex: afQuestions[index])
                                        : widget.quizzCountry == 'South America'
                                            ? BuildQ(
                                                quesIndex: saQuestions[index])
                                            : widget.quizzCountry ==
                                                    'World Flags'
                                                ? BuildQ(
                                                    quesIndex:
                                                        flQuestions[index])
                                                : BuildQ(
                                                    quesIndex:
                                                        questions[index]),
                    // SizedBox(
                    //   height: 40.0,
                    // ),
                    RawMaterialButton(
                      onPressed: () {
                        if (_controller!.page?.toInt() ==
                            questions.length - 1) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ResultScreen(score)));
                        } else {
                          _controller!.nextPage(
                              duration: Duration(milliseconds: 250),
                              curve: Curves.easeInExpo);

                          setState(() {
                            btnPressed = false;
                          });
                        }
                      },
                      shape: StadiumBorder(),
                      fillColor: Colors.blue,
                      padding: EdgeInsets.all(18.0),
                      elevation: 0.0,
                      child: Text(
                        btnText,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Spacer(),

                  ],
                );
              },
              itemCount: widget.quizzCountry == 'Europe'
                  ? euQuestions.length
                  : widget.quizzCountry == 'North America'
                      ? naQuestions.length
                      : widget.quizzCountry == 'Oceania'
                          ? ocQuestions.length
                          : widget.quizzCountry == 'Asia'
                              ? asQuestions.length
                              : widget.quizzCountry == 'Africa'
                                  ? afQuestions.length
                                  : widget.quizzCountry == 'South America'
                                      ? saQuestions.length
                                      : widget.quizzCountry == 'World Flags'
                                          ? flQuestions.length
                                          : questions.length)),
    );
  }
}

class BuildQ extends StatefulWidget {
  dynamic quesIndex;
  BuildQ({this.quesIndex, Key? key}) : super(key: key);

  @override
  State<BuildQ> createState() => _BuildQState();
}

class _BuildQState extends State<BuildQ> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < widget.quesIndex.answers!.length; i++)
          Container(
            width: double.infinity,
            height: 35.0,
            margin: EdgeInsets.only(bottom: 20.0, left: 12.0, right: 12.0),
            child: RawMaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              fillColor: btnPressed
                  ? widget.quesIndex.answers!.values.toList()[i]
                      ? Colors.green
                      : Colors.red
                  : AppColor.secondaryColor,
              onPressed: answered
                  ? () {
                      if (widget.quesIndex.answers!.values.toList()[i]) {
                        score++;
                        print("yes");
                      } else {
                        print("no");
                      }
                      setState(() {
                        btnPressed = true;
                        answered = true;
                      });
                    }
                  : null,
              child: Text(widget.quesIndex.answers!.keys.toList()[i],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  )),
            ),
          ),
      ],
    );
  }
}
