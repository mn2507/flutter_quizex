import 'package:flutter/foundation.dart';

class Result with ChangeNotifier {
  final String totalScore;
  final String dateTime;
  final String totalDuration;
  final String chosenCategory;
  final String chosenDifficulty;
  final String chosenType;

  Result({
    @required this.totalScore,
    @required this.dateTime,
    @required this.totalDuration,
    @required this.chosenCategory,
    @required this.chosenDifficulty,
    @required this.chosenType,
  });
}
