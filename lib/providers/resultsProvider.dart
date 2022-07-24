import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'result.dart';

enum ResultsStatus { ERROR, LOADING, DONE }

class ResultsProvider with ChangeNotifier {
  List<Result> _items = [];

  List<Result> get items {
    return [..._items];
  }

  Future getResults() async {
    final url = Uri.parse(
        'quizex-flutter-default-rtdb.asia-southeast1.firebasedatabase.app/scoreboard.json');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Result> loadedResults = [];
      extractedData.forEach((resultId, resultData) {
        loadedResults.add(Result(
          totalScore: resultData['totalScore'],
          dateTime: resultData['dateTime'],
          totalDuration: resultData['totalDuration'],
        ));
      });
      _items = loadedResults;
      notifyListeners();
    } catch (error) {
      print("getResultsError: $error");
      throw (error);
    }
  }

  Future addResult(Result result) async {
    var url = Uri.https(
        'quizex-flutter-default-rtdb.asia-southeast1.firebasedatabase.app',
        '/scoreboard.json');
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'totalScore': result.totalScore,
          'dateTime': result.dateTime,
          'totalDuration': result.totalDuration,
        }),
      );
      notifyListeners();
    } catch (error) {
      print("addResultError: $error");
      throw error;
    }
  }
}
