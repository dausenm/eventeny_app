import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/event.dart';
import '../widgets/quantity_selector.dart';
import '../models/cart_item.dart';
import '../providers/cart_providers.dart';
import '../providers/ticket_providers.dart';
import '../providers/ticket_quantity_provider.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_footer.dart';
import '../widgets/event_image_widget.dart';

class EventDetailsScreen extends ConsumerWidget {
  final Event event;

  const EventDetailsScreen({required this.event, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ticketsAsyncValue = ref.watch(ticketsProvider(event.id));
    final ticketQuantities = ref.watch(ticketQuantityProvider);

    return Scaffold(
      appBar: CustomAppBar(
        titleWidget: Text(
          event.name,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      bottomNavigationBar: const CustomFooter(),
      body: ticketsAsyncValue.when(
        data: (tickets) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              EventImageWidget(
                imageUrl: event.imageUrl,
                heroTag: 'eventImage_${event.id}',
              ),
              const SizedBox(height: 16),
              Text(event.description, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 20),
              ...tickets.map((ticket) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${ticket.type} - \$${ticket.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text('${ticket.quantityAvailable} available'),
                        const SizedBox(height: 16),
                        ticket.quantityAvailable == 0
                            ? const Text(
                              "Out of stock",
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            )
                            : QuantitySelector(
                              maxQuantity: ticket.quantityAvailable,
                              initialQuantity: ticketQuantities[ticket.id] ?? 0,
                              onQuantityChanged: (qty) {
                                ref
                                    .read(ticketQuantityProvider.notifier)
                                    .setQuantity(ticket.id, qty);
                              },
                            ),
                      ],
                    ),
                  ),
                );
              }),
              const SizedBox(height: 20),
              ElevatedButton(
                child: const Text("Add to Cart"),
                onPressed:
                    ticketQuantities.values.any((qty) => qty > 0)
                        ? () {
                          for (var ticket in tickets) {
                            final quantity = ticketQuantities[ticket.id] ?? 0;
                            if (quantity > 0) {
                              ref
                                  .read(cartProvider.notifier)
                                  .addToCart(
                                    CartItem(
                                      eventId: event.id,
                                      eventName: event.name,
                                      ticketId: ticket.id,
                                      ticketType: ticket.type,
                                      quantity: quantity,
                                      price: ticket.price,
                                    ),
                                  );
                            }
                          }
                          // Clear quantities after adding to cart
                          ref.read(ticketQuantityProvider.notifier).clear();

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Tickets added to cart!"),
                            ),
                          );
                        }
                        : null,
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text("Error: $err")),
      ),
    );
  }
}
