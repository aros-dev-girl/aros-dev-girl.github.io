import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tiara/modelos/cart_item.dart';
import 'package:tiara/modelos/membro.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemsCount {
    return items.length;
  }

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(Membro membro) {
    if (_items.containsKey(membro.id)) {
      _items.update(
        membro.id,
        (existingItem) => CartItem(
          id: existingItem.id,
          membroId: existingItem.membroId,
          name: existingItem.name,
          quantity: existingItem.quantity + 1,
          price: existingItem.price,
        ),
      );
    } else {
      _items.putIfAbsent(
        membro.id,
        () => CartItem(
          id: Random().nextDouble().toString(),
          membroId: membro.id,
          name: membro.nomeArtistico,
          quantity: 1,
          price: membro.altura,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String membroId) {
    _items.remove(membroId);
    notifyListeners();
  }

  void removeSingleItem(String membroId) {
    if (!_items.containsKey(membroId)) {
      return;
    }

    if (_items[membroId]?.quantity == 1) {
      _items.remove(membroId);
    } else {
      _items.update(
        membroId,
        (existingItem) => CartItem(
          id: existingItem.id,
          membroId: existingItem.membroId,
          name: existingItem.name,
          quantity: existingItem.quantity - 1,
          price: existingItem.price,
        ),
      );
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
