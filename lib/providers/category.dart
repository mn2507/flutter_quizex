import 'package:flutter/foundation.dart';
class Category with ChangeNotifier {
  final String id;
  final String name;

  Category({
    @required this.id,
    @required this.name,
  });
}
