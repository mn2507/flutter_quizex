import 'package:flutter/foundation.dart';

class QuestionParams with ChangeNotifier {
  final String amount;
  final String category;
  final String difficulty;
  final String type;

  QuestionParams({
    @required this.amount,
    @required this.category,
    @required this.difficulty,
    @required this.type,
  });
}
