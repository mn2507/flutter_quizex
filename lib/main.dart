import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizex_flutter/providers/questionsProvider.dart';
import 'package:quizex_flutter/screens/menu_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quizex',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.deepOrange,
      ),
      home: MenuScreen(),
      // routes: {
      //   ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
      //   CartScreen.routeName: (ctx) => CartScreen(),
      //   OrdersScreen.routeName: (ctx) => OrdersScreen(),
      //   UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
      //   EditProductScreen.routeName: (ctx) => EditProductScreen(),
      // }
    );
  }
}
