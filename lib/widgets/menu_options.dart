import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizex_flutter/providers/category.dart';
import 'package:quizex_flutter/providers/categoriesProvider.dart';
import 'package:quizex_flutter/providers/questionParams.dart';
import 'package:quizex_flutter/providers/questionsProvider.dart';
import 'package:quizex_flutter/screens/question_screen_main.dart';
import 'package:quizex_flutter/screens/scoreboard_screen.dart';

class MenuOptions extends StatefulWidget {
  const MenuOptions({Key key}) : super(key: key);

  @override
  State<MenuOptions> createState() => _MenuOptionsState();
}

class _MenuOptionsState extends State<MenuOptions> {
  String questionsDropdownValue = '10';
  String categoryDropdownValue;
  String difficultyDropdownValue = '';
  String typeDropdownValue = '';

  List<Category> _category;
  String _errorMessage;
  CategoryStatus _categoryStatus;
  QuestionsStatus _questionsStatus;
  QuestionParams _questionParams;

  final _amount = const [
    {'value': '10', 'label': '10'},
    {'value': '20', 'label': '20'},
    {'value': '30', 'label': '30'},
    {'value': '40', 'label': '40'},
    {'value': '50', 'label': '50'},
  ];

  final _difficulty = const [
    {'value': '', 'label': 'Any'},
    {'value': 'easy', 'label': 'Easy'},
    {'value': 'medium', 'label': 'Medium'},
    {'value': 'hard', 'label': 'Hard'},
  ];

  final _type = const [
    {'value': '', 'label': 'Any'},
    {'value': 'multiple', 'label': 'Multiple'},
    {'value': 'boolean', 'label': 'True/False'},
  ];

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

  Future<void> _startQuiz(BuildContext ctx) async {
    try {
      _questionsStatus = QuestionsStatus.LOADING;
      var questionsResponse =
          await Provider.of<QuestionsProvider>(context, listen: false)
              .generateQuestions(_questionParams);
      _questionsStatus = QuestionsStatus.DONE;
      setState(() {
        Navigator.of(ctx).pushNamed(QuestionScreenMain.routeName);
      });
    } catch (error) {
      _questionsStatus = QuestionsStatus.ERROR;
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('An error occurred!'),
          content: const Text('Something went wrong.'),
          actions: <Widget>[
            FlatButton(
              child: const Text('Okay'),
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
        body: _categoryStatus == CategoryStatus.DONE &&
                _questionsStatus != QuestionsStatus.LOADING
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
                        items: _difficulty.map((difficulty) {
                          return DropdownMenuItem(
                            value: difficulty['value'],
                            child: Text(difficulty['label']),
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
                        items: _type.map((type) {
                          return DropdownMenuItem(
                            value: type['value'],
                            child: Text(type['label']),
                          );
                        }).toList(),
                        onChanged: (String newValue) {
                          setState(() {
                            typeDropdownValue = newValue;
                          });
                        },
                      ),
                    ),

                    // Start Quiz button
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
                            _startQuiz(context);
                          },
                          child: const Text('Start Quiz'),
                        ),
                      ),
                    ),

                    // Scoreboard button
                    Container(
                      margin: const EdgeInsets.only(
                        top: 20,
                      ),
                      child: SizedBox(
                        height: 50,
                        width: 200,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(ScoreboardScreen.routeName);
                          },
                          child: const Text('Scoreboard'),
                        ),
                      ),
                    )
                  ],
                ),
              )
            : _categoryStatus == CategoryStatus.ERROR
                ? Center(
                    child: Text(_errorMessage),
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
      ),
    );
  }
}
