import 'package:flutter/foundation.dart';

class Result with ChangeNotifier {
  final int totalScore;
  final String dateTime;
  final int totalDuration;

  Result({
    @required this.totalScore,
    @required this.dateTime,
    @required this.totalDuration,
  });
}
