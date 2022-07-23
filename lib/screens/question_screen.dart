import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

class QuestionScreen extends StatefulWidget {
  static const routeName = '/question';

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Quizex")),
      body: Column(
        children: [
          Center(child: Text('Test'))
          // Question(
          //   questions[questionIndex]
          //       ['questionText'], // if getting error here, add "as String"
          // ),
          // ...(questions[questionIndex]['answers'] as List<Map<String, Object>>)
          //     .map((answer) {
          //   return Answer(() => answerQuestion(answer['score']),
          //       answer['text']); // if getting error here, add "as String"
          // }).toList()
        ],
      ),
    );
  }
}
