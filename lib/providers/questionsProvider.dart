import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:http/http.dart' as http;
import 'package:quizex_flutter/providers/questionParams.dart';

import 'question.dart';

enum QuestionsStatus { ERROR, LOADING, DONE }

class QuestionsProvider with ChangeNotifier {
  String errorMessage = "Network Error";
  List<Question> _items = [];

  List<Question> get items {
    return [..._items];
  }

  Future generateQuestions(QuestionParams questionParams) async {
    var queryParameters = {
      'amount': questionParams.amount,
      'category': questionParams.category ?? '',
      'difficulty': questionParams.difficulty,
      'type': questionParams.type,
    };
    var url = Uri.https('opentdb.com', '/api.php', queryParameters);
    print("queryParameters: $queryParameters");
    try {
      final response = await http.post(url);
      var body = response.body;
      final extractedData = json.decode(body)['results'];
      print("response $extractedData");
      final List<Question> loadedQuestion = [];
      var unescape = HtmlUnescape();

      extractedData.forEach((questionData) {
        List<String> incorrectAnswersString =
            questionData["incorrect_answers"].cast<String>();

        loadedQuestion.add(Question(
          category: questionData["category"].toString(),
          type: questionData["type"].toString(),
          difficulty: questionData["difficulty"].toString(),
          question: unescape.convert(questionData["question"].toString()),
          correctAnswer: questionData["correct_answer"].toString(),
          incorrectAnswers: incorrectAnswersString,
        ));
      });
      _items = loadedQuestion;
      notifyListeners();
    } catch (error) {
      print("questionsProviderError: $error");
      throw error;
    }
  }
}
