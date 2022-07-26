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
  final bool answered;

  QuestionScreen({
    @required this.questions,
    @required this.answerQuestion,
    @required this.questionIndex,
    @required this.answered,
  });

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  String _correctAnswer;
  List<String> allAnswers;

  @override
  Widget build(BuildContext context) {
    _correctAnswer = widget.questions[widget.questionIndex].correctAnswer;
    widget.answered ? print("answerQuestion yes") : print("answerQuestion no");
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        QuestionText(
          questionText: widget.questions[widget.questionIndex].question,
        ),
        ...(widget.questions[widget.questionIndex].allAnswers).map((answer) {
          return AnswerOptions(
            selectHandler: () => widget.answerQuestion(answer),
            answerText: answer,
            correctAnswer: _correctAnswer,
            answered: widget.answered,
          );
        }),
      ],
    );
  }
}
