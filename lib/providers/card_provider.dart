import 'package:cart_provider_app/models/cart_model.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  //cart items state
  final Map<String, CartItems> _items = {};

  //getter for return cart items
  Map<String, CartItems> get items => {..._items};

  //Add items
  void addItem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (existingCrtItem) => CartItems(
          id: existingCrtItem.id,
          tittle: existingCrtItem.tittle,
          price: existingCrtItem.price,
          quantity: existingCrtItem.quantity + 1,
        ),
      );
      print("add existing data");
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItems(
          id: productId,
          tittle: title,
          price: price,
          quantity: 1,
        ),
      );
      print("add New data");
    }
    notifyListeners();
  }

  //remove items from cart
  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  //remove single item from cart
  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]!.quantity > 1) {
      _items.update(
        productId,
        (existingCrtItem) => CartItems(
          id: existingCrtItem.id,
          tittle: existingCrtItem.tittle,
          price: existingCrtItem.price,
          quantity: existingCrtItem.quantity + 1,
        ),
      );
    }else {
      _items.remove(productId);
    }
    notifyListeners();
  }
}
