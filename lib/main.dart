import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizex_flutter/providers/categoriesProvider.dart';
import 'package:quizex_flutter/providers/questionsProvider.dart';
import 'package:quizex_flutter/screens/menu_screen.dart';
import 'package:quizex_flutter/screens/question_screen_main.dart';
import 'package:quizex_flutter/widgets/menu_options.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: CategoriesProvider(),
        ),
        ChangeNotifierProvider.value(
          value: QuestionsProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Quizex',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
        ),
        home: MenuOptions(),
        routes: {
          QuestionScreenMain.routeName: (ctx) => QuestionScreenMain(),
        },
      ),
    );
  }
}
