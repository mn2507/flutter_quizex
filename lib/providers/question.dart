import 'package:flutter/foundation.dart';
class Question with ChangeNotifier {
  final String category;
  final String type;
  final String difficulty;
  final String question;
  final String correctAnswer;
  final List<dynamic> incorrectAnswers;

  Question({
    @required this.category,
    @required this.type,
    @required this.difficulty,
    @required this.question,
    @required this.correctAnswer,
    @required this.incorrectAnswers,
  });
}
