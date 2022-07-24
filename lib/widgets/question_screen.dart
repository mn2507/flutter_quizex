import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:quizex_flutter/widgets/answer_options.dart';
import 'package:quizex_flutter/widgets/question_text.dart';
import '../providers/question.dart';

class QuestionScreen extends StatefulWidget {
  final List<Question> questions;
  final int questionIndex;
  final Function answerQuestion;

  QuestionScreen({
    @required this.questions,
    @required this.answerQuestion,
    @required this.questionIndex,
  });

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  List correctAnswerList = [];

  @override
  void didChangeDependencies() {
    correctAnswerList.add(
      widget.questions[widget.questionIndex].correctAnswer,
    );
    List allAnswers = widget.questions[widget.questionIndex].incorrectAnswers;
    allAnswers.addAll(correctAnswerList);
    allAnswers.shuffle();

    print("allAnswers: $allAnswers");
    print(widget.questions[widget.questionIndex].correctAnswer);
    print(widget.questions[widget.questionIndex].question);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        QuestionText(
          questionText: widget.questions[widget.questionIndex].question,
        ),
      ],
    );
  }
}
