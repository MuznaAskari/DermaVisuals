import 'CartPage.dart';

class CartManager {
  static List<CartItemModel> _cartItems = [];

  static void addToCart(CartItemModel product) {
    _cartItems.add(product);
  }

  static List<CartItemModel> getCartItems() {
    return _cartItems;
  }
}