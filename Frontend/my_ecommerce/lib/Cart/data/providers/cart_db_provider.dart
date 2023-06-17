import 'package:my_ecommerce/Utils/constants.dart';
import 'package:my_ecommerce/Utils/services/database_service.dart';
import '../models/cart.dart';
import '../models/cart_item.dart';

class CartDatabaseProvider extends DatabaseService {
  CartDatabaseProvider(super.secureStorage);

  Future<Cart?> fetchCart() async {
    final appDataBox = await Boxes.getAppDataBox();
    if (appDataBox.containsKey('cart'))
      return appDataBox.get('cart', defaultValue: null);
    final Cart cart = Cart(cartContent: [], total: 0, subtotal: 0);
    appDataBox.put('cart', cart);
    return cart;
  }

  Future<void> addToCart(CartItem item) async {
    final appDataBox = await Boxes.getAppDataBox();
    final currentCart = await fetchCart();
    final cartContent = currentCart?.cartContent;
    final index =
        cartContent!.indexWhere((element) => element.product == item.product);
    if (index != -1) {
      final cartItem = cartContent.elementAt(index);
      cartContent[index] = cartItem.copyWith(qty: cartItem.quantity + 1);
    } else {
      cartContent.add(item);
    }
    return appDataBox.put(
        'cart',
        currentCart?.copyWith(
          cartContent: cartContent,
          subtotal: cartContent.fold(
              0,
              (previousValue, element) =>
                  previousValue! + (element.product.price * element.quantity)),
          total: cartContent.fold(
              0,
              (previousValue, element) =>
                  previousValue! + (element.product.price * element.quantity)),
        ));
  }

  Future<void> updateCartItem(CartItem item) async {
    final appDataBox = await Boxes.getAppDataBox();
    final currentCart = await fetchCart();
    currentCart?.cartContent[currentCart.cartContent
        .indexWhere((element) => element.product.id == item.product.id)] = item;
    return appDataBox.put(
        'cart',
        currentCart?.copyWith(
          cartContent: List<CartItem>.of(currentCart.cartContent),
          subtotal: currentCart.cartContent.fold(
              0,
              (previousValue, element) =>
                  previousValue! + (element.product.price * element.quantity)),
          total: currentCart.cartContent.fold(
              0,
              (previousValue, element) =>
                  previousValue! + (element.product.price * element.quantity)),
        ));
  }

  Future<void> deleteCartItem(String id) async {
    final appDataBox = await Boxes.getAppDataBox();
    final currentCart = await fetchCart();
    final temp = currentCart?.cartContent;
    temp?.removeWhere((element) => element.product.id == id);
    return appDataBox.put(
        'cart',
        currentCart?.copyWith(
          cartContent: List<CartItem>.from(temp ?? []),
          subtotal: currentCart.cartContent.fold(
              0,
              (previousValue, element) =>
                  previousValue! + (element.product.price * element.quantity)),
          total: currentCart.cartContent.fold(
              0,
              (previousValue, element) =>
                  previousValue! + (element.product.price * element.quantity)),
        ));
  }

  Future<void> clearCart() async {
    final appDataBox = await Boxes.getAppDataBox();
    return await appDataBox.delete('cart');
  }
}
