import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quizex_flutter/providers/category.dart';

enum Status { ERROR, LOADING, DONE }

class QuestionsProvider with ChangeNotifier {
  String errorMessage = "Network Error";
  Status status;
  List<Category> _items = [];

  QuestionsProvider() {
    status = Status.LOADING;
    initScreen();
  }

  void initScreen() async {
    try {
      await fetchCategories();
      status = Status.DONE;
    } catch (e) {
      status = Status.ERROR;
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
      print("test");
      final response = await http.get(url);
      // print(json.decode(response.body));
      var body = response.body;
      final extractedData = json.decode(body)['trivia_categories'];
      final List<Category> loadedCategory = [];
      // print("test2 $extractedData");

      print(loadedCategory);

      extractedData.forEach((catData) {
        print(catData["id"]);
        loadedCategory.add(Category(
          id: catData["id"].toString(),
          name: catData["name"].toString(),
        ));
      });
      // print("test5 $loadedCategory");

      // List<Category> loadedCategory = extractedData
      //     .map(
      //       (category) => Categories(
      //         id: category.id,
      //         name: category.name,
      //       ),
      //     );

      // extractedData.forEach((catId, catData) {
      //   loadedCategory.add(catId
      //       .map(
      //         (category) => Category(
      //           id: category.id,
      //           name: category.name,
      //         ),
      //       )
      //       .toList());

      // loadedCategory.add(Category(
      //   id: catData.data()['id'],
      //   name: catData.data()['name'],
      // ));
      // });

      _items = loadedCategory;
      // notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  // Future<void> addProduct(Product product) async {
  //   var url = Uri.https(
  //       'flutter-test-f6b3c-default-rtdb.asia-southeast1.firebasedatabase.app',
  //       '/products.json');
  //   try {
  //     final response = await http.post(
  //       url,
  //       body: json.encode({
  //         'title': product.title,
  //         'description': product.description,
  //         'imageUrl': product.imageUrl,
  //         'price': product.price,
  //         'isFavorite': product.isFavorite,
  //       }),
  //     );
  //     final newProduct = Product(
  //       title: product.title,
  //       description: product.description,
  //       price: product.price,
  //       imageUrl: product.imageUrl,
  //       id: json.decode(response.body)['name'],
  //     );
  //     _items.add(newProduct);
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
