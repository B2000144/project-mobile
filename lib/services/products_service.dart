import 'dart:convert';
import '../models/product.dart';
import '../models/auth_token.dart';
import 'firebase_service.dart';

class ProductService extends FirebaseService {
  String? filters;
  ProductService([super.authToken]);
  Future<List<Product>> fetchProducts({bool filterByUser = false}) async {
    final List<Product> products = [];
    try {
      final productMap = await httpFetch(
        '$databaseUrl/products.json?auth=$token&$filters',
      ) as Map<String, dynamic>?;
      final userFavoritesMap = await httpFetch(
        '$databaseUrl/userFavorites/$userId.json?auth=$token',
      ) as Map<String, dynamic>?;
      productMap?.forEach((productId, product) {
        final isFavorite = (userFavoritesMap == null)
            ? false
            : (userFavoritesMap[productId] ?? false);
        products.add(
          Product.fromJson({'id': productId, ...product})
              .copyWith(isFavorite: isFavorite),
        );
      });
      return products;
    } catch (e) {
      print(e);
      return products;
    }
  }

  Future<Product?> addProduct(Product product) async {
    try {
      final newProduct = await httpFetch(
        '$databaseUrl/products.json?auth=$token',
        method: HttpMethod.post,
        body: jsonEncode(
          product.toJson()
            ..addAll({
              'creatorId': userId,
            }),
        ),
      ) as Map<String, dynamic>?;
      return product.copyWith(
        id: newProduct!['name'],
      );
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool> updateProduct(Product product) async {
    try {
      await httpFetch(
        '$databaseUrl/products/${product.id}.json?auth=$token',
        method: HttpMethod.patch,
        body: jsonEncode(product.toJson()),
      );
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteProduct(String id) async {
    try {
      await httpFetch(
        '$databaseUrl/products/$id.json?auth=$token',
        method: HttpMethod.delete,
      );
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> saveFavoriteStatus(Product product) async {
    try {
      await httpFetch(
        '$databaseUrl/userFavorites/$userId/${product.id}.json?auth=$token',
        method: HttpMethod.put,
        body: jsonEncode({'isFavorite': product.isFavorite}),
      );
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
