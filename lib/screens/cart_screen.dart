import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/cart_providers.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    final cartNotifier = ref.read(cartProvider.notifier);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    double total = cart.fold(
      0,
      (sum, item) => sum + (item.price * item.quantity),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            tooltip: "Clear Cart",
            onPressed: () {
              if (cart.isNotEmpty) {
                showDialog(
                  context: context,
                  builder:
                      (context) => AlertDialog(
                        title: const Text("Clear Cart"),
                        content: const Text(
                          "Are you sure you want to clear the cart?",
                        ),
                        actions: [
                          TextButton(
                            child: const Text("Cancel"),
                            onPressed: () => Navigator.pop(context),
                          ),
                          TextButton(
                            child: const Text("Clear"),
                            onPressed: () {
                              cartNotifier.clearCart();
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                );
              }
            },
          ),
        ],
      ),
      body:
          cart.isEmpty
              ? const Center(child: Text("Your cart is empty. Add some items!"))
              : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: cart.length,
                itemBuilder: (context, index) {
                  final item = cart[index];
                  return Card(
                    color: theme.cardColor,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.eventName,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "${item.ticketType} — \$${item.price.toStringAsFixed(2)}",
                            style: theme.textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Text("Quantity: "),
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed:
                                    item.quantity > 1
                                        ? () => cartNotifier.updateQuantity(
                                          item,
                                          item.quantity - 1,
                                        )
                                        : null,
                              ),
                              Text("${item.quantity}"),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed:
                                    () => cartNotifier.updateQuantity(
                                      item,
                                      item.quantity + 1,
                                    ),
                              ),
                              const Spacer(),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                color: colorScheme.error,
                                onPressed:
                                    () => cartNotifier.removeFromCart(item),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      bottomNavigationBar:
          cart.isEmpty
              ? null
              : Container(
                padding: const EdgeInsets.all(16),
                color: theme.cardColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total: \$${total.toStringAsFixed(2)}",
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.textTheme.titleLarge?.color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.appBarTheme.foregroundColor,
                      ),
                      onPressed:
                          () => Navigator.pushNamed(context, '/checkout'),
                      child: const Text("Checkout"),
                    ),
                  ],
                ),
              ),
    );
  }
}
