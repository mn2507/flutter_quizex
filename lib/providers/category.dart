import 'package:flutter/foundation.dart';

// class Category with ChangeNotifier {
//   final List<Categories> categories;

//   Category({
//     @required this.categories
//   });
// }

// class Categories with ChangeNotifier {
//   final String id;
//   final String name;

//   Categories({
//     @required this.id,
//     @required this.name,
//   });
// }

class Category with ChangeNotifier {
  final String id;
  final String name;

  Category({
    @required this.id,
    @required this.name,
  });
}
