import 'package:flutter/foundation.dart';

class Result with ChangeNotifier {
  final String totalScore;
  final String dateTime;
  final String totalDuration;

  Result({
    @required this.totalScore,
    @required this.dateTime,
    @required this.totalDuration,
  });
}
