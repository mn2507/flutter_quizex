import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizex_flutter/providers/question.dart';
import 'package:quizex_flutter/providers/questionsProvider.dart';
import 'package:quizex_flutter/widgets/question_screen.dart';

class QuestionScreenMain extends StatefulWidget {
  static const routeName = '/question';

  @override
  State<QuestionScreenMain> createState() => _QuestionScreenMainState();
}

class _QuestionScreenMainState extends State<QuestionScreenMain> {
  List<Question> _question;
  var _questionIndex = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final questionState = Provider.of<QuestionsProvider>(context);
    _question = questionState.items.map((items) {
      print('Entering');
      List<String> items2 = items.incorrectAnswers;
      items2.add(items.correctAnswer);
      items2.shuffle();
      items.allAnswers = items2;
      return items;
    }).toList();
    print(_question[0].question);

    // correctAnswerList = widget.questions[widget.questionIndex].correctAnswer;
    // allAnswers = widget.questions[widget.questionIndex].incorrectAnswers;

    // allAnswers.add(correctAnswerList);

    // allAnswers.shuffle();

    // print("allAnswers: $allAnswers");
    // print(widget.questions[widget.questionIndex].correctAnswer);
    // print(widget.questions[widget.questionIndex].question);
    // print("status: $_categoryStatus");
  }

  void _answerQuestion() {
    setState(() {
      _questionIndex = _questionIndex + 1;
    });
    print("_questionIndex: $_questionIndex");
    if (_questionIndex < _question.length) {
      print('We have more questions!');
    } else {
      print('No more questions!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Quizex")),
      body: Column(
        children: [
          _questionIndex < _question.length
              ? QuestionScreen(
                  questions: _question,
                  answerQuestion: _answerQuestion,
                  questionIndex: _questionIndex,
                )
              : Center(child: Text('Finished'))
        ],
      ),
    );
  }
}
