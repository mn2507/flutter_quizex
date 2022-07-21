import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizex_flutter/providers/category.dart';
import 'package:quizex_flutter/providers/categoriesProvider.dart';
import 'package:quizex_flutter/providers/questionParams.dart';
import 'package:quizex_flutter/providers/questionsProvider.dart';

class MenuOptions extends StatefulWidget {
  const MenuOptions({Key key}) : super(key: key);

  @override
  State<MenuOptions> createState() => _MenuOptionsState();
}

class _MenuOptionsState extends State<MenuOptions> {
  String questionsDropdownValue = '10';
  String categoryDropdownValue;
  String difficultyDropdownValue = 'Any';
  String typeDropdownValue = 'Any';

  List<Category> _category;
  String _errorMessage;
  CategoryStatus _categoryStatus;
  QuestionsStatus _questionsStatus;
  QuestionParams _questionParams;

  final _questions = const [
    {
      'questionText': 'What\'s your favorite color?',
      'answers': [
        {'text': 'Black', 'score': 10},
        {'text': 'Red', 'score': 5},
        {'text': 'Green', 'score': 3},
        {'text': 'White', 'score': 1}
      ],
    },
    {
      'questionText': 'What\'s your favorite animal?',
      'answers': [
        {'text': 'Rabbit', 'score': 3},
        {'text': 'Snake', 'score': 11},
        {'text': 'Elephant', 'score': 5},
        {'text': 'Lion', 'score': 9}
      ],
    },
    {
      'questionText': 'Who\'s your favorite instructor?',
      'answers': [
        {'text': 'Max', 'score': 1},
        {'text': 'Mux', 'score': 1},
        {'text': 'Mix', 'score': 1},
        {'text': 'Mox', 'score': 1}
      ]
    },
  ];

  var _questionIndex = 0;
  var _totalScore = 0;

  @override
  void initState() {
    // Provider.of<QuizQuestions>(context, listen: false).fetchCategories();
    // Future.delayed(Duration.zero).then((_) {
    //   Provider.of<QuizQuestions>(context).fetchCategories();
    // });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final categoryState = Provider.of<CategoriesProvider>(context);
    _categoryStatus = categoryState.categoryStatus;
    _errorMessage = categoryState.errorMessage;
    if (_categoryStatus == CategoryStatus.DONE) {
      _category = categoryState.items;
      // print("category: $_category");
    }
    // print("status: $_categoryStatus");
  }

  void _resetQuiz() {
    setState(() {
      // setState calls the build method everytime it has been triggered
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  void _answerQuestion(int score) {
    // Similar shorthands exist for subtraction (-=), multiplication(*=) or division (/=)
    _totalScore += score;

    setState(() {
      _questionIndex = _questionIndex + 1;
    });
    print(_questionIndex);
    if (_questionIndex < _questions.length) {
      print('We have more questions!');
    } else {
      print('No more questions!');
    }
  }

  void _setOptions() {
    setState(() {
      _questionParams = QuestionParams(
        amount: questionsDropdownValue,
        category: categoryDropdownValue,
        difficulty: difficultyDropdownValue,
        type: typeDropdownValue,
      );
    });
  }

  Future<void> _startQuiz() async {
    try {
      _questionsStatus = QuestionsStatus.LOADING;
      await Provider.of<QuestionsProvider>(context, listen: false)
          .generateQuestions(_questionParams);
      _questionsStatus = QuestionsStatus.DONE;
    } catch (error) {
      _questionsStatus = QuestionsStatus.ERROR;
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('An error occurred!'),
          content: Text('Something went wrong.'),
          actions: <Widget>[
            FlatButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.deepOrange,
      ),
      home: Scaffold(
          appBar: AppBar(title: const Text("Quizex")),
          body: _categoryStatus == CategoryStatus.DONE
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // No. of questions
                      const Text(
                        'Select number of questions:',
                        style: TextStyle(fontSize: 22),
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(left: 8.0),
                        child: DropdownButton<String>(
                          value: questionsDropdownValue,
                          items: <String>['10', '20', '30', '40', '50']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String newValue) {
                            setState(() {
                              questionsDropdownValue = newValue;
                            });
                          },
                        ),
                      ),

                      // Category
                      const Text(
                        'Select category:',
                        style: TextStyle(fontSize: 22),
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(left: 8.0),
                        child: DropdownButton(
                          hint: const Text('Any'),
                          value: categoryDropdownValue,
                          items: _category.map((category) {
                            return DropdownMenuItem(
                              value: category.id,
                              child: Text(category.name),
                            );
                          }).toList(),
                          onChanged: (String newValue) {
                            setState(() {
                              categoryDropdownValue = newValue;
                            });
                          },
                        ),
                      ),

                      //Difficulty
                      const Text(
                        'Select difficulty:',
                        style: TextStyle(fontSize: 22),
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(left: 8.0),
                        child: DropdownButton<String>(
                          value: difficultyDropdownValue,
                          items: <String>['Any', 'Easy', 'Medium', 'Hard']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String newValue) {
                            setState(() {
                              difficultyDropdownValue = newValue;
                            });
                          },
                        ),
                      ),

                      // Type
                      const Text(
                        'Select type:',
                        style: TextStyle(fontSize: 22),
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(left: 8.0),
                        child: DropdownButton<String>(
                          value: typeDropdownValue,
                          items: <String>[
                            'Any',
                            'Multiple Choice',
                            'True/False'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String newValue) {
                            setState(() {
                              typeDropdownValue = newValue;
                            });
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 20,
                        ),
                        child: SizedBox(
                          height: 50,
                          width: 200,
                          child: ElevatedButton(
                            onPressed: () {
                              _setOptions();
                              _startQuiz();
                            },
                            child: const Text('Start Quiz'),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 20,
                        ),
                        child: SizedBox(
                          height: 50,
                          width: 200,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: const Text('Scoreboard'),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              : _categoryStatus == CategoryStatus.ERROR
                  ? Center(
                      child: Text("$_errorMessage"),
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    )

          // body: _questionIndex < _questions.length
          //     ? Quiz(
          //         answerQuestion: _answerQuestion,
          //         questionIndex: _questionIndex,
          //         questions: _questions,
          //       )
          //     : Result(_totalScore, _resetQuiz),
          ),
    );
  }
}
