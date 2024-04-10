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

  void updateProduct(Product product) {
    final index = _items.indexWhere((item) => item.id == product.id);
    if (index >= 0) {
      _items[index] = product;
      notifyListeners();
    }
  }

  void toggleFavoriteStatus(Product product) {
    final saveStatus = product.isFavorite;
    product.isFavorite = !saveStatus;
  }

  void deleteProduct(String id) {
    final index = _items.indexWhere((item) => item.id == id);
    _items.removeAt(index);
    notifyListeners();
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
