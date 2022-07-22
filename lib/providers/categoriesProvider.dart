import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quizex_flutter/providers/category.dart';
import 'package:quizex_flutter/providers/questionParams.dart';

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

  // List<Category> get favoriteItems {
  //   return _items.where((prodItem) => prodItem.isFavorite).toList();
  // }

  // Category findById(String id) {
  //   return _items.firstWhere((prod) => prod.id == id);
  // }

  // void showFavoritesOnly() {
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }

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
      throw (error);
    }
  }

  // Future<void> generateQuestions(QuestionParams questionParams) async {
  //   var queryParameters = {
  //     'amount': questionParams.amount,
  //     'category': questionParams.category,
  //     'difficulty': questionParams.difficulty,
  //     'type': questionParams.type,
  //   };
  //   var url = Uri.https('opentdb.com', '/api.php', queryParameters);
  //   try {
  //     final response = await http.post(url);
  //     print("response $response");
  //     // _items.add(newProduct);
  //     // _items.insert(0, newProduct); // at the start of the list
  //     notifyListeners();
  //   } catch (error) {
  //     print(error);
  //     throw error;
  //   }
  // }

  // void updateProduct(String id, Product newProduct) {
  //   final prodIndex = _items.indexWhere((prod) => prod.id == id);
  //   if (prodIndex >= 0) {
  //     _items[prodIndex] = newProduct;
  //     notifyListeners();
  //   } else {
  //     print('...');
  //   }
  // }

  // void deleteProduct(String id) {
  //   _items.removeWhere((prod) => prod.id == id);
  //   notifyListeners();
  // }
}
