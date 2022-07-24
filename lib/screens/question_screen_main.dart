import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quizex_flutter/providers/question.dart';
import 'package:quizex_flutter/providers/questionsProvider.dart';
import 'package:quizex_flutter/providers/result.dart';
import 'package:quizex_flutter/providers/resultsProvider.dart';
import 'package:quizex_flutter/widgets/question_screen.dart';

class QuestionScreenMain extends StatefulWidget {
  static const routeName = '/question';

  @override
  State<QuestionScreenMain> createState() => _QuestionScreenMainState();
}

class _QuestionScreenMainState extends State<QuestionScreenMain> {
  List<Question> _question;
  var _questionIndex = 0;
  var _totalScore = 0;
  String _startDateTime;
  String _endDateTime;
  DateTime _startDuration;
  DateTime _endDuration;
  Duration _totalDuration;
  ResultsStatus _resultsStatus;
  Result _result;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final questionState = Provider.of<QuestionsProvider>(context);
    _startDateTime = DateFormat('dd/MM/yyyy HH:mm:ss').format(DateTime.now());
    _startDuration = DateTime.now();
    print("startTime: $_startDateTime");
    _question = questionState.items.map((items) {
      List<String> allAnswerItems = items.incorrectAnswers;
      allAnswerItems.add(items.correctAnswer);
      allAnswerItems.shuffle();
      items.allAnswers = allAnswerItems;
      return items;
    }).toList();
    // print(_question[0].question);
  }

  void _answerQuestion(String answeredText) {
    print("answeredText: $answeredText");
    print(_question[_questionIndex].correctAnswer);
    if (answeredText == _question[_questionIndex].correctAnswer) {
      _totalScore += 1;
    }
    setState(() {
      _questionIndex = _questionIndex + 1;
    });
    // print("_questionIndex: $_questionIndex");
    if (_questionIndex < _question.length) {
      // print('We have more questions!');
    } else {
      _endDateTime = DateFormat('dd/MM/yyyy HH:mm:ss').format(DateTime.now());
      _endDuration = DateTime.now();
      print("endTime: $_endDateTime");
      _totalDuration = _endDuration.difference(_startDuration);
      print("duration: ${_totalDuration.inSeconds}");

      _setResultData();
      // print('No more questions!');
    }
  }

  void _setResultData() {
    setState(() {
      _result = Result(
        totalScore: _totalScore,
        dateTime: _startDateTime,
        totalDuration: _totalDuration.inSeconds,
      );
    });
    _generateResult();
  }

  Future _generateResult() async {
    try {
      _resultsStatus = ResultsStatus.LOADING;
      var questionsResponse =
          await Provider.of<ResultsProvider>(context, listen: false)
              .addResult(_result);
      _resultsStatus = ResultsStatus.DONE;
    } catch (error) {
      _resultsStatus = ResultsStatus.ERROR;
      print("_generateResultError: $error");
      throw error;
      // await showDialog(
      //   context: context,
      //   builder: (ctx) => AlertDialog(
      //     title: const Text('An error occurred!'),
      //     content: const Text('Something went wrong.'),
      //     actions: <Widget>[
      //       FlatButton(
      //         child: const Text('Okay'),
      //         onPressed: () {
      //           Navigator.of(ctx).pop();
      //         },
      //       )
      //     ],
      //   ),
      // );
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
              : Center(
                  child: Text('Total Score: $_totalScore/${_question.length}'),
                )
        ],
      ),
    );
  }
}
