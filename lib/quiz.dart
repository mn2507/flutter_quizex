import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import './question.dart';
import './answer.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final int questionIndex;
  // If getting error when using "Function", use "VoidCallback" instead
  final Function answerQuestion;

  Quiz({
    @required this.questions, //If getting error with @required, use required
    @required this.answerQuestion,
    @required this.questionIndex,
  }); // Named argument

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        QuestionOld(
          questions[questionIndex]
              ['questionText'], // if getting error here, add "as String"
        ),
        ...(questions[questionIndex]['answers'] as List<Map<String, Object>>)
            .map((answer) {
          return Answer(() => answerQuestion(answer['score']),
              answer['text']); // if getting error here, add "as String"
        }).toList()
      ],
    );
  }
}
