import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizex_flutter/providers/categoriesProvider.dart';
import 'package:quizex_flutter/screens/menu_screen.dart';
import 'package:quizex_flutter/screens/question_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quizex',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.deepOrange,
      ),
      home: MenuScreen(),
      routes: {
        QuestionScreen.routeName: (ctx) => QuestionScreen()
      }
    );
  }
}
