import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'product_grid_title.dart';
import '../../models/product.dart';
import 'products_manager.dart';

class ProductsGird extends StatelessWidget {
  final bool showFavorites;

  const ProductsGird(this.showFavorites, {super.key});

  @override
  Widget build(BuildContext context) {
    final products = context.select<ProductsManager, List<Product>>(
        (productsManager) => showFavorites
            ? productsManager.favoriteItems
            : productsManager.items);
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      itemBuilder: (ctx, i) => ProductGirdTile(products[i]),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 1 / 1,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
