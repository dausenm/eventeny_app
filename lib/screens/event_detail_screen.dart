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
import '../utils/date_formatter.dart';

class EventDetailsScreen extends ConsumerWidget {
  final Event event;

  const EventDetailsScreen({required this.event, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ticketsAsyncValue = ref.watch(ticketsProvider(event.id));
    final ticketQuantities = ref.watch(ticketQuantityProvider);

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: CustomAppBar(
        titleWidget: Text(
          ' ',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      bottomNavigationBar: const CustomFooter(),
      body: ticketsAsyncValue.when(
        data: (tickets) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                event.name,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.textTheme.titleLarge?.color,
                ),
              ),
              EventImageWidget(
                imageUrl: event.imageUrl,
                heroTag: 'eventImage_${event.id}',
              ),
              const SizedBox(height: 16),
              Text(
                formatDateTime(event.date),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.secondary,
                ),
              ),
              const SizedBox(height: 8),
              Text(event.description, style: theme.textTheme.bodyLarge),
              const SizedBox(height: 20),

              ...tickets.map((ticket) {
                final isSoldOut = ticket.quantityAvailable == 0;
                return Card(
                  color: theme.cardColor,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${ticket.type} - \$${ticket.price.toStringAsFixed(2)}',
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${ticket.quantityAvailable} available',
                          style: theme.textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 16),
                        isSoldOut
                            ? Text(
                              "Out of stock",
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
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
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.cardColor,
                  foregroundColor: theme.textTheme.bodyMedium?.color,
                  textStyle: theme.textTheme.bodyMedium,
                ),
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
