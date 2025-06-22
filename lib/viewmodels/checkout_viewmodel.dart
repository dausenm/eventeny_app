import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cart_item.dart';
import '../models/purchase.dart';
import '../providers/cart_providers.dart';
import '../providers/submit_order_provider.dart';
import '../providers/event_providers.dart';
import '../providers/ticket_providers.dart';

final checkoutViewModelProvider = Provider((ref) => CheckoutViewModel(ref));

class CheckoutViewModel {
  final Ref ref;

  CheckoutViewModel(this.ref);

  Future<void> submitOrder({
    required String name,
    required String email,
    required List<CartItem> cart,
  }) async {
    final purchase = Purchase(name: name, email: email, cart: cart);
    await ref.read(submitOrderProvider(purchase).future);
    ref.invalidate(eventListProvider);
    ref.invalidate(ticketsProvider);
    ref.read(cartProvider.notifier).clearCart();
  }
}
