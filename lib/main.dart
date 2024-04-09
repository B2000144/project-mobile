import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myshop/ui/product/products_overview_screen.dart';
import 'ui/product/product_detail_screen.dart';
import 'ui/product/products_manager.dart';
import 'ui/product/user_products_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: Colors.blue,
      secondary: Colors.deepOrange,
      background: Colors.white,
      surfaceTint: Colors.grey[200],
    );

    return MaterialApp(
      title: 'My Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Lato',
        colorScheme: colorScheme,
        appBarTheme: AppBarTheme(
            backgroundColor: colorScheme.primary,
            foregroundColor: colorScheme.onPrimary,
            elevation: 4,
            shadowColor: colorScheme.shadow),
      ),
      home: const SafeArea(
        child: UserProductsScreen(),
      ),
    );
  }
}
