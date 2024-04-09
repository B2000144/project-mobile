import 'package:flutter/material.dart';

import 'product_grid_title.dart';

import 'products_manager.dart';

class ProductsGird extends StatelessWidget {
  final bool showFavorites;

  const ProductsGird(this.showFavorites, {super.key});

  @override
  Widget build(BuildContext context) {
    final productsManager = ProductsManager();

    final products =
        showFavorites ? productsManager.favoriteItems : productsManager.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      itemBuilder: (ctx, i) => ProductGirdTile(products[i]),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1 / 1,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
