import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cart_item.dart';

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  return CartNotifier();
});

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  void addToCart(CartItem item) {
    final index = state.indexWhere(
      (i) => i.eventId == item.eventId && i.ticketId == item.ticketId,
    );
    if (index >= 0) {
      final updated = [...state];
      updated[index] = updated[index].copyWith(
        quantity: updated[index].quantity + item.quantity,
      );
      state = updated;
    } else {
      state = [...state, item];
    }
  }

  void updateQuantity(CartItem item, int newQuantity) {
    final index = state.indexWhere(
      (i) => i.eventId == item.eventId && i.ticketId == item.ticketId,
    );
    if (index >= 0) {
      if (newQuantity > 0) {
        final updated = [...state];
        updated[index] = updated[index].copyWith(quantity: newQuantity);
        state = updated;
      } else {
        removeFromCart(item);
      }
    }
  }

  void removeFromCart(CartItem item) {
    state =
        state
            .where(
              (i) =>
                  !(i.eventId == item.eventId && i.ticketId == item.ticketId),
            )
            .toList();
  }

  void clearCart() {
    state = [];
  }
}
