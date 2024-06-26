import 'package:flutter/cupertino.dart';

import '../../models/cart_item.dart';
import '../../models/product.dart';

class CartManager with ChangeNotifier {
  final Map<String, CartItem> _items = {};
  int get productCount {
    return _items.length;
  }

  List<CartItem> get products {
    return _items.values.toList();
  }

  Iterable<MapEntry<String, CartItem>> get productEntries {
    return {..._items}.entries;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(
        product.id!,
        (existingCartItem) => existingCartItem.copyWith(
          quantity: existingCartItem.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        product.id!, // Sử dụng toán tử ! để bỏ qua cảnh báo về null
        () => CartItem(
          id: 'c${DateTime.now().toIso8601String()}',
          title: product.title ??
              '', // Kiểm tra nếu title là null, gán một giá trị mặc định (trong trường hợp này là chuỗi rỗng)
          imageUrl: product.imageUrl ?? '', // Tương tự cho các thuộc tính khác
          price: product.price ?? 0.0,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void removeItems(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]?.quantity as num > 1) {
      _items.update(
        productId,
        (existingCartItem) => existingCartItem.copyWith(
          quantity: existingCartItem.quantity - 1,
        ),
      );
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clearItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clearAllItems() {
    _items.clear(); // Xóa tất cả các mục trong _items
    notifyListeners();
  }
}
