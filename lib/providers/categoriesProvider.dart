import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quizex_flutter/providers/category.dart';

enum CategoryStatus { ERROR, LOADING, DONE }

class CategoriesProvider with ChangeNotifier {
  String errorMessage = "Network Error";
  CategoryStatus categoryStatus;
  List<Category> _items = [];

  CategoriesProvider() {
    categoryStatus = CategoryStatus.LOADING;
    initScreen();
  }

  void initScreen() async {
    try {
      await fetchCategories();
      categoryStatus = CategoryStatus.DONE;
    } catch (e) {
      categoryStatus = CategoryStatus.ERROR;
    }
    notifyListeners();
  }

  List<Category> get items {
    return [..._items];
  }

  Category findById(String id) {
    return _items.firstWhere((cat) => cat.id == id);
  }

  Future fetchCategories() async {
    final url = Uri.parse('https://opentdb.com/api_category.php');
    try {
      // print("test");
      final response = await http.get(url);
      var body = response.body;
      final extractedData = json.decode(body)['trivia_categories'];
      final List<Category> loadedCategory = [];

      extractedData.forEach((catData) {
        // print(catData["id"]);
        loadedCategory.add(Category(
          id: catData["id"].toString(),
          name: catData["name"].toString(),
        ));
      });
      _items = loadedCategory;
      // notifyListeners();
    } catch (error) {
      print("categoriesProviderError: $error");
      throw (error);
    }
  }
}
