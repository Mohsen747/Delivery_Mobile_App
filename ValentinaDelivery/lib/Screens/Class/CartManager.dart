// ignore: file_names
import 'CartItem.dart';

class CartManager {
  static final CartManager _instance = CartManager._internal();

  factory CartManager() {
    return _instance;
  }

  CartManager._internal();

  List<CartItem> cartItems = [];

  void addItemToCart(CartItem newItem) {

    int index = cartItems.indexWhere(
            (item) => item.title == newItem.title && item.image == newItem.image);
    if (index != -1) {
      cartItems[index].quantity += newItem.quantity;
    } else {
      cartItems.add(newItem);
    }
  }

  void incrementItemQuantity(String title, String image) {
    int index = _findItemIndex(title, image);
    if (index != -1) {
      cartItems[index].quantity++;
    }
  }

  void decrementItemQuantity(String title, String image) {
    int index = _findItemIndex(title, image);
    if (index != -1 && cartItems[index].quantity > 1) {
      cartItems[index].quantity--;
    }
  }

  int _findItemIndex(String title, String image) {
    return cartItems.indexWhere(
            (item) => item.title == title && item.image == image);
  }

  void removeItem(String title, String image) {
    cartItems.removeWhere(
            (item) => item.title == title && item.image == image);
  }

  void clearCart() {
    cartItems.clear();
  }


}