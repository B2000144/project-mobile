import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../../models/product.dart';
import '../../models/auth_token.dart';
import '../../services/products_service.dart';

class ProductsManager with ChangeNotifier {
  List<Product> _items = [];
  final ProductService _productService;
  ProductsManager([AuthToken? authToken])
      : _productService = ProductService(authToken);
  set authToken(AuthToken? authToken) {
    _productService.authToken = authToken;
  }

  Future<void> fetchProducts() async {
    _items = await _productService.fetchProducts();
    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    final newProduct = await _productService.addProduct(product);
    if (newProduct != null) {
      _items.add(newProduct);
      notifyListeners();
    }
  }

  Future<void> updateProduct(product) async {
    final index = _items.indexWhere((item) => item.id == product.id);
    if (index >= 0) {
      if (await _productService.updateProduct(product)) {
        _items[index] = product;
        notifyListeners();
      }
    }
  }

  void toggleFavoriteStatus(Product product) async {
    final saveStatus = product.isFavorite;
    product.isFavorite = !saveStatus;
    if (!await _productService.saveFavoriteStatus(product)) {
      product.isFavorite = saveStatus;
    }
  }

  void deleteProduct(String id) async {
    final index = _items.indexWhere((item) => item.id == id);
    Product? existringProduct = _items[index];
    _items.removeAt(index);
    notifyListeners();
    if (!await _productService.deleteProduct(id)) {
      _items.insert(index, existringProduct);
      notifyListeners();
    }
  }

  int get itemCount {
    return _items.length;
  }

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((item) => item.isFavorite ?? false).toList();
  }

  Product? findById(id) {
    try {
      return _items.firstWhere((item) => item.id == id);
    } catch (error) {
      return null;
    }
  }
}
