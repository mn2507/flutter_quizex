import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quizex_flutter/providers/categoriesProvider.dart';
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
  var _answered = false;

  String chosenCategoryId;
  String chosenDifficulty;
  String chosenType;
  String chosenCategoryName = "Any";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Get chosen category and difficulty
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    chosenCategoryId = routeArgs['chosenCategoryId'];
    chosenDifficulty = routeArgs['chosenDifficulty'];
    chosenType = routeArgs['chosenType'];
    if (chosenCategoryId.isNotEmpty) {
      var chosenCategory = Provider.of<CategoriesProvider>(
        context,
        listen: false,
      ).findById(chosenCategoryId);
      chosenCategoryName = chosenCategory.name;
      // print("chosenCategoryName:  $chosenCategoryName");
    }

    // Set quiz start time
    final questionState = Provider.of<QuestionsProvider>(context);
    _startDateTime = DateFormat('dd/MM/yyyy HH:mm:ss').format(DateTime.now());
    _startDuration = DateTime.now();
    // print("startTime: $_startDateTime");
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
    // print("answeredText: $answeredText");
    // print(_question[_questionIndex].correctAnswer);
    if (answeredText == _question[_questionIndex].correctAnswer) {
      _totalScore += 1;
    }
    setState(() {
      _answered = true;
    });
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _questionIndex = _questionIndex + 1;
        _answered = false;
      });
      // print("_questionIndex: $_questionIndex");
      if (_questionIndex < _question.length) {
        // print('We have more questions!');
      } else {
        _endDateTime = DateFormat('dd/MM/yyyy HH:mm:ss').format(DateTime.now());
        _endDuration = DateTime.now();
        // print("endTime: $_endDateTime");
        _totalDuration = _endDuration.difference(_startDuration);
        // print("duration: ${_totalDuration.inSeconds}");

        _setResultData();
        // print('No more questions!');
      }
    });
  }

  void _setResultData() {
    setState(() {
      _result = Result(
        totalScore: '$_totalScore/${_question.length}',
        dateTime: _startDateTime,
        totalDuration: '${_totalDuration.inSeconds} seconds',
        chosenCategory: chosenCategoryName,
        chosenDifficulty: chosenDifficulty,
        chosenType: chosenType,
      );
    });
    _generateResult();
  }

  Future _generateResult() async {
    try {
      _resultsStatus = ResultsStatus.LOADING;
      // print("_resultsStatus: $_resultsStatus");
      var questionsResponse =
          await Provider.of<ResultsProvider>(context, listen: false)
              .addResult(_result);
      _resultsStatus = ResultsStatus.DONE;
      // print("_resultsStatus: $_resultsStatus");
    } catch (error) {
      _resultsStatus = ResultsStatus.ERROR;
      // print("_generateResultError: $error");
      rethrow;
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
      body: _question.isNotEmpty
          ? _questionIndex < _question.length
              ? QuestionScreen(
                  questions: _question,
                  answerQuestion: _answerQuestion,
                  questionIndex: _questionIndex,
                  answered: _answered,
                )
              : Center(
                  child: Text('Total Score: $_totalScore/${_question.length}',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      )),
                )
          : const Center(
              child: Text('No questions available for the selected options.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  )),
            ),
    );
  }
}
